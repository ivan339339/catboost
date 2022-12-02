PY3_LIBRARY()



VERSION(1.5.1)

LICENSE(BSD-3-Clause)

PEERDIR(
    contrib/python/dateutil
    contrib/python/numpy
    contrib/python/pytz
)

ADDINCL(
    FOR cython contrib/python/pandas/py3
    contrib/python/pandas/py3/pandas/_libs
    contrib/python/pandas/py3/pandas/_libs/src
    contrib/python/pandas/py3/pandas/_libs/src/klib
    contrib/python/pandas/py3/pandas/_libs/src/ujson/lib
    contrib/python/pandas/py3/pandas/_libs/tslibs
)

NO_COMPILER_WARNINGS()

NO_LINT()

NO_CHECK_IMPORTS(
    pandas._testing._hypothesis
    pandas.core._numba.*
    pandas.core.arrays.arrow.*
    pandas.io.*
    pandas.plotting.*
    pandas.tseries.*
    pandas.util.*
)

CFLAGS(
    -D__LITTLE_ENDIAN__=1
    -DNPY_NO_DEPRECATED_API=0
)

INCLUDE(symbols.cmake)

SRCS(
    pandas/_libs/src/parser/io.c
    pandas/_libs/src/parser/tokenizer.c
    pandas/_libs/src/ujson/lib/ultrajsondec.c
    pandas/_libs/src/ujson/lib/ultrajsonenc.c
    pandas/_libs/src/ujson/python/JSONtoObj.c
    pandas/_libs/src/ujson/python/date_conversions.c
    pandas/_libs/src/ujson/python/objToJSON.c
    pandas/_libs/src/ujson/python/ujson.c
    pandas/_libs/tslibs/src/datetime/np_datetime.c
    pandas/_libs/tslibs/src/datetime/np_datetime_strings.c
)

PY_REGISTER(
    pandas._libs.json
)

PY_SRCS(
    TOP_LEVEL
    pandas/__init__.py
    pandas/_config/__init__.py
    pandas/_config/config.py
    pandas/_config/dates.py
    pandas/_config/display.py
    pandas/_config/localization.py
    pandas/_libs/__init__.py
    pandas/_libs/algos.pyi
    pandas/_libs/arrays.pyi
    pandas/_libs/groupby.pyi
    pandas/_libs/hashing.pyi
    pandas/_libs/hashtable.pyi
    pandas/_libs/index.pyi
    pandas/_libs/indexing.pyi
    pandas/_libs/internals.pyi
    pandas/_libs/interval.pyi
    pandas/_libs/join.pyi
    pandas/_libs/json.pyi
    pandas/_libs/lib.pyi
    pandas/_libs/missing.pyi
    pandas/_libs/ops.pyi
    pandas/_libs/ops_dispatch.pyi
    pandas/_libs/parsers.pyi
    pandas/_libs/properties.pyi
    pandas/_libs/reduction.pyi
    pandas/_libs/reshape.pyi
    pandas/_libs/sparse.pyi
    pandas/_libs/testing.pyi
    pandas/_libs/tslib.pyi
    pandas/_libs/tslibs/__init__.py
    pandas/_libs/tslibs/ccalendar.pyi
    pandas/_libs/tslibs/conversion.pyi
    pandas/_libs/tslibs/dtypes.pyi
    pandas/_libs/tslibs/fields.pyi
    pandas/_libs/tslibs/nattype.pyi
    pandas/_libs/tslibs/np_datetime.pyi
    pandas/_libs/tslibs/offsets.pyi
    pandas/_libs/tslibs/parsing.pyi
    pandas/_libs/tslibs/period.pyi
    pandas/_libs/tslibs/strptime.pyi
    pandas/_libs/tslibs/timedeltas.pyi
    pandas/_libs/tslibs/timestamps.pyi
    pandas/_libs/tslibs/timezones.pyi
    pandas/_libs/tslibs/tzconversion.pyi
    pandas/_libs/tslibs/vectorized.pyi
    pandas/_libs/window/__init__.py
    pandas/_libs/window/aggregations.pyi
    pandas/_libs/window/indexers.pyi
    pandas/_libs/writers.pyi
    pandas/_testing/__init__.py
    pandas/_testing/_hypothesis.py
    pandas/_testing/_io.py
    pandas/_testing/_random.py
    pandas/_testing/_warnings.py
    pandas/_testing/asserters.py
    pandas/_testing/compat.py
    pandas/_testing/contexts.py
    pandas/_typing.py
    pandas/_version.py
    pandas/api/__init__.py
    pandas/api/extensions/__init__.py
    pandas/api/indexers/__init__.py
    pandas/api/interchange/__init__.py
    pandas/api/types/__init__.py
    pandas/arrays/__init__.py
    pandas/compat/__init__.py
    pandas/compat/_optional.py
    pandas/compat/chainmap.py
    pandas/compat/numpy/__init__.py
    pandas/compat/numpy/function.py
    pandas/compat/pickle_compat.py
    pandas/compat/pyarrow.py
    pandas/core/__init__.py
    pandas/core/_numba/__init__.py
    pandas/core/_numba/executor.py
    pandas/core/_numba/kernels/__init__.py
    pandas/core/_numba/kernels/mean_.py
    pandas/core/_numba/kernels/min_max_.py
    pandas/core/_numba/kernels/shared.py
    pandas/core/_numba/kernels/sum_.py
    pandas/core/_numba/kernels/var_.py
    pandas/core/accessor.py
    pandas/core/algorithms.py
    pandas/core/api.py
    pandas/core/apply.py
    pandas/core/array_algos/__init__.py
    pandas/core/array_algos/masked_reductions.py
    pandas/core/array_algos/putmask.py
    pandas/core/array_algos/quantile.py
    pandas/core/array_algos/replace.py
    pandas/core/array_algos/take.py
    pandas/core/array_algos/transforms.py
    pandas/core/arraylike.py
    pandas/core/arrays/__init__.py
    pandas/core/arrays/_mixins.py
    pandas/core/arrays/_ranges.py
    pandas/core/arrays/arrow/__init__.py
    pandas/core/arrays/arrow/_arrow_utils.py
    pandas/core/arrays/arrow/array.py
    pandas/core/arrays/arrow/dtype.py
    pandas/core/arrays/arrow/extension_types.py
    pandas/core/arrays/base.py
    pandas/core/arrays/boolean.py
    pandas/core/arrays/categorical.py
    pandas/core/arrays/datetimelike.py
    pandas/core/arrays/datetimes.py
    pandas/core/arrays/floating.py
    pandas/core/arrays/integer.py
    pandas/core/arrays/interval.py
    pandas/core/arrays/masked.py
    pandas/core/arrays/numeric.py
    pandas/core/arrays/numpy_.py
    pandas/core/arrays/period.py
    pandas/core/arrays/sparse/__init__.py
    pandas/core/arrays/sparse/accessor.py
    pandas/core/arrays/sparse/array.py
    pandas/core/arrays/sparse/dtype.py
    pandas/core/arrays/sparse/scipy_sparse.py
    pandas/core/arrays/string_.py
    pandas/core/arrays/string_arrow.py
    pandas/core/arrays/timedeltas.py
    pandas/core/base.py
    pandas/core/common.py
    pandas/core/computation/__init__.py
    pandas/core/computation/align.py
    pandas/core/computation/api.py
    pandas/core/computation/check.py
    pandas/core/computation/common.py
    pandas/core/computation/engines.py
    pandas/core/computation/eval.py
    pandas/core/computation/expr.py
    pandas/core/computation/expressions.py
    pandas/core/computation/ops.py
    pandas/core/computation/parsing.py
    pandas/core/computation/pytables.py
    pandas/core/computation/scope.py
    pandas/core/config_init.py
    pandas/core/construction.py
    pandas/core/describe.py
    pandas/core/dtypes/__init__.py
    pandas/core/dtypes/api.py
    pandas/core/dtypes/astype.py
    pandas/core/dtypes/base.py
    pandas/core/dtypes/cast.py
    pandas/core/dtypes/common.py
    pandas/core/dtypes/concat.py
    pandas/core/dtypes/dtypes.py
    pandas/core/dtypes/generic.py
    pandas/core/dtypes/inference.py
    pandas/core/dtypes/missing.py
    pandas/core/flags.py
    pandas/core/frame.py
    pandas/core/generic.py
    pandas/core/groupby/__init__.py
    pandas/core/groupby/base.py
    pandas/core/groupby/categorical.py
    pandas/core/groupby/generic.py
    pandas/core/groupby/groupby.py
    pandas/core/groupby/grouper.py
    pandas/core/groupby/indexing.py
    pandas/core/groupby/numba_.py
    pandas/core/groupby/ops.py
    pandas/core/index.py
    pandas/core/indexers/__init__.py
    pandas/core/indexers/objects.py
    pandas/core/indexers/utils.py
    pandas/core/indexes/__init__.py
    pandas/core/indexes/accessors.py
    pandas/core/indexes/api.py
    pandas/core/indexes/base.py
    pandas/core/indexes/category.py
    pandas/core/indexes/datetimelike.py
    pandas/core/indexes/datetimes.py
    pandas/core/indexes/extension.py
    pandas/core/indexes/frozen.py
    pandas/core/indexes/interval.py
    pandas/core/indexes/multi.py
    pandas/core/indexes/numeric.py
    pandas/core/indexes/period.py
    pandas/core/indexes/range.py
    pandas/core/indexes/timedeltas.py
    pandas/core/indexing.py
    pandas/core/interchange/__init__.py
    pandas/core/interchange/buffer.py
    pandas/core/interchange/column.py
    pandas/core/interchange/dataframe.py
    pandas/core/interchange/dataframe_protocol.py
    pandas/core/interchange/from_dataframe.py
    pandas/core/interchange/utils.py
    pandas/core/internals/__init__.py
    pandas/core/internals/api.py
    pandas/core/internals/array_manager.py
    pandas/core/internals/base.py
    pandas/core/internals/blocks.py
    pandas/core/internals/concat.py
    pandas/core/internals/construction.py
    pandas/core/internals/managers.py
    pandas/core/internals/ops.py
    pandas/core/missing.py
    pandas/core/nanops.py
    pandas/core/ops/__init__.py
    pandas/core/ops/array_ops.py
    pandas/core/ops/common.py
    pandas/core/ops/dispatch.py
    pandas/core/ops/docstrings.py
    pandas/core/ops/invalid.py
    pandas/core/ops/mask_ops.py
    pandas/core/ops/methods.py
    pandas/core/ops/missing.py
    pandas/core/resample.py
    pandas/core/reshape/__init__.py
    pandas/core/reshape/api.py
    pandas/core/reshape/concat.py
    pandas/core/reshape/encoding.py
    pandas/core/reshape/melt.py
    pandas/core/reshape/merge.py
    pandas/core/reshape/pivot.py
    pandas/core/reshape/reshape.py
    pandas/core/reshape/tile.py
    pandas/core/reshape/util.py
    pandas/core/roperator.py
    pandas/core/sample.py
    pandas/core/series.py
    pandas/core/shared_docs.py
    pandas/core/sorting.py
    pandas/core/sparse/__init__.py
    pandas/core/sparse/api.py
    pandas/core/strings/__init__.py
    pandas/core/strings/accessor.py
    pandas/core/strings/base.py
    pandas/core/strings/object_array.py
    pandas/core/tools/__init__.py
    pandas/core/tools/datetimes.py
    pandas/core/tools/numeric.py
    pandas/core/tools/timedeltas.py
    pandas/core/tools/times.py
    pandas/core/util/__init__.py
    pandas/core/util/hashing.py
    pandas/core/util/numba_.py
    pandas/core/window/__init__.py
    pandas/core/window/common.py
    pandas/core/window/doc.py
    pandas/core/window/ewm.py
    pandas/core/window/expanding.py
    pandas/core/window/numba_.py
    pandas/core/window/online.py
    pandas/core/window/rolling.py
    pandas/errors/__init__.py
    pandas/io/__init__.py
    pandas/io/api.py
    pandas/io/clipboard/__init__.py
    pandas/io/clipboards.py
    pandas/io/common.py
    pandas/io/date_converters.py
    pandas/io/excel/__init__.py
    pandas/io/excel/_base.py
    pandas/io/excel/_odfreader.py
    pandas/io/excel/_odswriter.py
    pandas/io/excel/_openpyxl.py
    pandas/io/excel/_pyxlsb.py
    pandas/io/excel/_util.py
    pandas/io/excel/_xlrd.py
    pandas/io/excel/_xlsxwriter.py
    pandas/io/excel/_xlwt.py
    pandas/io/feather_format.py
    pandas/io/formats/__init__.py
    pandas/io/formats/_color_data.py
    pandas/io/formats/console.py
    pandas/io/formats/css.py
    pandas/io/formats/csvs.py
    pandas/io/formats/excel.py
    pandas/io/formats/format.py
    pandas/io/formats/html.py
    pandas/io/formats/info.py
    pandas/io/formats/latex.py
    pandas/io/formats/printing.py
    pandas/io/formats/string.py
    pandas/io/formats/style.py
    pandas/io/formats/style_render.py
    pandas/io/formats/xml.py
    pandas/io/gbq.py
    pandas/io/html.py
    pandas/io/json/__init__.py
    pandas/io/json/_json.py
    pandas/io/json/_normalize.py
    pandas/io/json/_table_schema.py
    pandas/io/orc.py
    pandas/io/parquet.py
    pandas/io/parsers/__init__.py
    pandas/io/parsers/arrow_parser_wrapper.py
    pandas/io/parsers/base_parser.py
    pandas/io/parsers/c_parser_wrapper.py
    pandas/io/parsers/python_parser.py
    pandas/io/parsers/readers.py
    pandas/io/pickle.py
    pandas/io/pytables.py
    pandas/io/sas/__init__.py
    pandas/io/sas/_sas.pyi
    pandas/io/sas/sas7bdat.py
    pandas/io/sas/sas_constants.py
    pandas/io/sas/sas_xport.py
    pandas/io/sas/sasreader.py
    pandas/io/spss.py
    pandas/io/sql.py
    pandas/io/stata.py
    pandas/io/xml.py
    pandas/plotting/__init__.py
    pandas/plotting/_core.py
    pandas/plotting/_matplotlib/__init__.py
    pandas/plotting/_matplotlib/boxplot.py
    pandas/plotting/_matplotlib/compat.py
    pandas/plotting/_matplotlib/converter.py
    pandas/plotting/_matplotlib/core.py
    pandas/plotting/_matplotlib/groupby.py
    pandas/plotting/_matplotlib/hist.py
    pandas/plotting/_matplotlib/misc.py
    pandas/plotting/_matplotlib/style.py
    pandas/plotting/_matplotlib/timeseries.py
    pandas/plotting/_matplotlib/tools.py
    pandas/plotting/_misc.py
    pandas/testing.py
    pandas/tseries/__init__.py
    pandas/tseries/api.py
    pandas/tseries/frequencies.py
    pandas/tseries/holiday.py
    pandas/tseries/offsets.py
    pandas/util/__init__.py
    pandas/util/_decorators.py
    pandas/util/_doctools.py
    pandas/util/_exceptions.py
    pandas/util/_print_versions.py
    pandas/util/_test_decorators.py
    pandas/util/_tester.py
    pandas/util/_validators.py
    pandas/util/testing.py
    pandas/util/version/__init__.py
    CYTHON_DIRECTIVE
    language_level=3
    CYTHON_C
    pandas/_libs/algos.pyx
    pandas/_libs/arrays.pyx
    pandas/_libs/groupby.pyx
    pandas/_libs/hashing.pyx
    pandas/_libs/hashtable.pyx
    pandas/_libs/index.pyx
    pandas/_libs/indexing.pyx
    pandas/_libs/internals.pyx
    pandas/_libs/interval.pyx
    pandas/_libs/join.pyx
    pandas/_libs/lib.pyx
    pandas/_libs/missing.pyx
    pandas/_libs/ops.pyx
    pandas/_libs/ops_dispatch.pyx
    pandas/_libs/parsers.pyx
    pandas/_libs/properties.pyx
    pandas/_libs/reduction.pyx
    pandas/_libs/reshape.pyx
    pandas/_libs/sparse.pyx
    pandas/_libs/testing.pyx
    pandas/_libs/tslib.pyx
    pandas/_libs/tslibs/base.pyx
    pandas/_libs/tslibs/ccalendar.pyx
    pandas/_libs/tslibs/conversion.pyx
    pandas/_libs/tslibs/dtypes.pyx
    pandas/_libs/tslibs/fields.pyx
    pandas/_libs/tslibs/nattype.pyx
    pandas/_libs/tslibs/np_datetime.pyx
    pandas/_libs/tslibs/offsets.pyx
    pandas/_libs/tslibs/parsing.pyx
    pandas/_libs/tslibs/period.pyx
    pandas/_libs/tslibs/strptime.pyx
    pandas/_libs/tslibs/timedeltas.pyx
    pandas/_libs/tslibs/timestamps.pyx
    pandas/_libs/tslibs/timezones.pyx
    pandas/_libs/tslibs/tzconversion.pyx
    pandas/_libs/tslibs/vectorized.pyx
    pandas/_libs/window/indexers.pyx
    pandas/_libs/writers.pyx
    pandas/io/sas/sas.pyx
    CYTHON_CPP
    pandas/_libs/window/aggregations.pyx
)

RESOURCE_FILES(
    PREFIX contrib/python/pandas/py3/
    .dist-info/METADATA
    .dist-info/entry_points.txt
    .dist-info/top_level.txt
    pandas/io/formats/templates/html.tpl
    pandas/io/formats/templates/html_style.tpl
    pandas/io/formats/templates/html_table.tpl
    pandas/io/formats/templates/latex.tpl
    pandas/io/formats/templates/latex_longtable.tpl
    pandas/io/formats/templates/latex_table.tpl
    pandas/io/formats/templates/string.tpl
)

END()
