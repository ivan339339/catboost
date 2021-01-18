
%{
#include <catboost/libs/data/data_provider.h>
#include <catboost/libs/data/objects.h>
#include <catboost/libs/helpers/exception.h>
%}

%include "tvector.i"


namespace NCB {
    class TRawObjectsDataProviderPtr;
    class TQuantizedObjectsDataProviderPtr {
    };


    /**
     * Black box for SWIG because it is impossible to declare it using TIntrusivePtr because
     *  TDataProver does not have a default constructor
     *  All methods will be added as external.
     */
    class TDataProviderPtr {
    public:
        %extend {
            i64 GetObjectCount() const {
                return (*self)->GetObjectCount();
            }
            
            NCB::TQuantizedObjectsDataProviderPtr GetQuantizedObjectsDataProvider() const throw(yexception) {
                auto* quantizedObjectsDataProvider
                    = dynamic_cast<NCB::TQuantizedForCPUObjectsDataProvider*>((*self)->ObjectsData.Get());
                CB_ENSURE_INTERNAL(quantizedObjectsDataProvider, "Features data is not quantized");
                return NCB::TQuantizedObjectsDataProviderPtr(quantizedObjectsDataProvider);
            }
        }
    };
    
    class TEstimatedForCPUObjectsDataProviders {
    public:
        NCB::TQuantizedObjectsDataProviderPtr Learn; // can be nullptr
        TVector<NCB::TQuantizedObjectsDataProviderPtr> Test;
    };
}

%template(TVector_TDataProviderPtr) TVector<NCB::TDataProviderPtr>;
%template(TVector_TQuantizedObjectsDataProviderPtr) TVector<NCB::TQuantizedObjectsDataProviderPtr>;
