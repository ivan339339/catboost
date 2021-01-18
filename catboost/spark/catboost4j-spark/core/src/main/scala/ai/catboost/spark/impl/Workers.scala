package ai.catboost.spark.impl

import collection.mutable.HashMap

import java.net._
import java.util.concurrent.{ExecutorCompletionService,Executors}
import java.util.concurrent.atomic.AtomicBoolean

import org.json4s._
import org.json4s.jackson.JsonMethods._
import org.json4s.JsonDSL._

import org.apache.spark.sql.types.StructType
import org.apache.spark.sql.{Row,SparkSession}
import org.apache.spark.TaskContext

import ru.yandex.catboost.spark.catboost4j_spark.core.src.native_impl._

import ai.catboost.CatBoostError
import ai.catboost.spark._

import java.io.File


private[spark] object Worker {
  val usedInCurrentProcess : AtomicBoolean = new AtomicBoolean

  def processPartition(
    trainingDriverListeningAddress: InetSocketAddress,
    catBoostJsonParamsString: String,
    quantizedFeaturesInfo: QuantizedFeaturesInfoPtr,
    precomputedOnlineCtrMetaDataAsJsonString: String,
    threadCount: Int,
    
    // returns (quantizedDataProvider, estimatedQuantizedDataProvider) can return null
    getDataProvidersCallback : () => (TDataProviderPtr, TDataProviderPtr)
  ) = {
    if (!usedInCurrentProcess.compareAndSet(false, true)) {
      throw new CatBoostError("An active CatBoost worker is already present in the current process")
    }

    try {
      // TaskContext.getPartitionId will become invalid when iteration over rows is finished, so save it
      val partitionId = TaskContext.getPartitionId

      var (quantizedDataProvider, estimatedQuantizedDataProvider) = getDataProvidersCallback()

      val partitionSize = if (quantizedDataProvider != null) quantizedDataProvider.GetObjectCount.toInt else 0

      if (partitionSize != 0) {
        native_impl.CreateTrainingDataForWorker(
          partitionId,
          threadCount,
          catBoostJsonParamsString,
          quantizedDataProvider,
          quantizedFeaturesInfo,
          if (estimatedQuantizedDataProvider != null) {
            estimatedQuantizedDataProvider
          } else {
            new TDataProviderPtr
          },
          if (precomputedOnlineCtrMetaDataAsJsonString != null) {
            precomputedOnlineCtrMetaDataAsJsonString
          } else {
            ""
          }
        )
      }

      val workerPort = TrainingDriver.getWorkerPort()

      val ecs = new ExecutorCompletionService[Unit](Executors.newFixedThreadPool(2))

      val sendWorkerInfoFuture = ecs.submit(
        new Runnable() {
          def run() = {
            TrainingDriver.waitForListeningPortAndSendWorkerInfo(
              trainingDriverListeningAddress,
              partitionId,
              partitionSize,
              workerPort
            )
          }
        },
        ()
      )

      val workerFuture = ecs.submit(
        new Runnable() {
          def run() = {
            if (partitionSize != 0) {
              native_impl.RunWorkerWrapper(threadCount, workerPort)
            }
          }
        },
        ()
      )

      val firstCompletedFuture = ecs.take()

      if (firstCompletedFuture == workerFuture) {
        impl.Helpers.checkOneFutureAndWaitForOther(workerFuture, sendWorkerInfoFuture, "native_impl.RunWorkerWrapper")
      } else { // firstCompletedFuture == sendWorkerInfoFuture
        impl.Helpers.checkOneFutureAndWaitForOther(
          sendWorkerInfoFuture,
          workerFuture,
          "TrainingDriver.waitForListeningPortAndSendWorkerInfo"
        )
      }

    } finally {
      usedInCurrentProcess.set(false)
    }
  }
}


private[spark] class Workers(
  val spark: SparkSession,
  val workerCount: Int,
  val trainingDriverListeningPort: Int,
  val preprocessedTrainPool: Pool,
  val catBoostJsonParams: JObject,
  val precomputedOnlineCtrMetaDataAsJsonString: String
) extends Runnable {
  def run() = {
    val trainingDriverListeningAddress = new InetSocketAddress(
      SparkHelpers.getDriverHost(spark),
      trainingDriverListeningPort
    )

    val quantizedFeaturesInfo = preprocessedTrainPool.quantizedFeaturesInfo

    val (trainDataForWorkers, columnIndexMapForWorkers, estimatedFeatureCount) 
      = DataHelpers.selectColumnsForTrainingAndReturnIndex(
          preprocessedTrainPool,
          includeFeatures = true,
          includeSampleId = (preprocessedTrainPool.pairsData != null),
          includeEstimatedFeatures = true
        )

    val threadCount = SparkHelpers.getThreadCountForTask(spark)

    var catBoostJsonParamsForWorkers = catBoostJsonParams ~ ("thread_count" -> threadCount)

    val executorNativeMemoryLimit = SparkHelpers.getExecutorNativeMemoryLimit(spark)
    if (executorNativeMemoryLimit.isDefined) {
      catBoostJsonParamsForWorkers
        = catBoostJsonParamsForWorkers ~ ("used_ram_limit" -> s"${executorNativeMemoryLimit.get / 1024}KB")
    }

    val catBoostJsonParamsForWorkersString = compact(catBoostJsonParamsForWorkers)

    val dataMetaInfo = preprocessedTrainPool.createDataMetaInfo
    val schemaForWorkers = trainDataForWorkers.schema

    // copy needed because Spark will try to capture the whole Workers class and fail
    val precomputedOnlineCtrMetaDataAsJsonStringCopy = precomputedOnlineCtrMetaDataAsJsonString
    
    if (preprocessedTrainPool.pairsData != null) {
      val cogroupedTrainData = DataHelpers.getCogroupedMainAndPairsRDD(
        trainDataForWorkers, 
        columnIndexMapForWorkers("groupId"), 
        preprocessedTrainPool.pairsData
      ).repartition(workerCount)
      val pairsSchema = preprocessedTrainPool.pairsData.schema

      cogroupedTrainData.foreachPartition {
        groups : Iterator[(Long, (Iterable[Iterable[Row]], Iterable[Iterable[Row]]))] => {
          Worker.processPartition(
            trainingDriverListeningAddress,
            catBoostJsonParamsForWorkersString,
            quantizedFeaturesInfo,
            precomputedOnlineCtrMetaDataAsJsonStringCopy,
            threadCount,
            () => {
              if (groups.hasNext) {
                DataHelpers.loadQuantizedDatasetsWithPairs(
                  quantizedFeaturesInfo,
                  columnIndexMapForWorkers,
                  dataMetaInfo,
                  schemaForWorkers,
                  pairsSchema,
                  estimatedFeatureCount,
                  threadCount,
                  groups
                )
              } else {
                null
              }
           }
          )
        }
      }
    } else {
      trainDataForWorkers.repartition(workerCount).foreachPartition {
        rows : Iterator[Row] => {
          Worker.processPartition(
            trainingDriverListeningAddress,
            catBoostJsonParamsForWorkersString,
            quantizedFeaturesInfo,
            precomputedOnlineCtrMetaDataAsJsonStringCopy,
            threadCount,
            () => {
              if (rows.hasNext) {
                DataHelpers.loadQuantizedDatasets(
                  quantizedFeaturesInfo,
                  columnIndexMapForWorkers,
                  dataMetaInfo,
                  schemaForWorkers,
                  estimatedFeatureCount,
                  threadCount,
                  rows
                )
              } else {
                null
              }
            }
          )
        }
      }
    }
  }
}
