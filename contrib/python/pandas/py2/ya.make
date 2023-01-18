PY2_LIBRARY()

LICENSE(BSD-3-Clause)

VERSION(0.24.2)



PEERDIR(
    contrib/python/Jinja2
    contrib/python/python-dateutil
    contrib/python/numpy
    contrib/python/pytz
)

ADDINCL(
    FOR cython contrib/python/pandas/py2
    contrib/python/pandas/py2/pandas/_libs
    contrib/python/pandas/py2/pandas/_libs/src
    contrib/python/pandas/py2/pandas/_libs/src/klib
    contrib/python/pandas/py2/pandas/_libs/src/ujson/lib
    contrib/python/pandas/py2/pandas/_libs/tslibs
)

NO_CHECK_IMPORTS(
    pandas.io.*
    pandas.plotting.*
    pandas.tseries.*
    pandas.util.*
)

NO_COMPILER_WARNINGS()

NO_LINT()

INCLUDE(symbols.cmake)

PY_REGISTER(pandas._libs.json)
PY_REGISTER(pandas.util._move)

SRCS(
    pandas/_libs/src/parser/io.c
    pandas/_libs/src/parser/tokenizer.c
    pandas/_libs/src/ujson/lib/ultrajsondec.c
    pandas/_libs/src/ujson/lib/ultrajsonenc.c
    pandas/_libs/src/ujson/python/JSONtoObj.c
    pandas/_libs/src/ujson/python/objToJSON.c
    pandas/_libs/src/ujson/python/ujson.c
    pandas/_libs/tslibs/src/datetime/np_datetime.c
    pandas/_libs/tslibs/src/datetime/np_datetime_strings.c
    pandas/util/move.c
)

PY_SRCS(
    TOP_LEVEL

    CYTHON_C
    pandas/_libs/algos.pyx
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
    pandas/_libs/parsers.pyx
    pandas/_libs/properties.pyx
    pandas/_libs/reduction.pyx
    pandas/_libs/reshape.pyx
    pandas/_libs/skiplist.pyx
    pandas/_libs/sparse.pyx
    pandas/_libs/testing.pyx
    pandas/_libs/tslib.pyx
    pandas/_libs/tslibs/ccalendar.pyx
    pandas/_libs/tslibs/conversion.pyx
    pandas/_libs/tslibs/fields.pyx
    pandas/_libs/tslibs/frequencies.pyx
    pandas/_libs/tslibs/nattype.pyx
    pandas/_libs/tslibs/np_datetime.pyx
    pandas/_libs/tslibs/offsets.pyx
    pandas/_libs/tslibs/parsing.pyx
    pandas/_libs/tslibs/period.pyx
    pandas/_libs/tslibs/resolution.pyx
    pandas/_libs/tslibs/strptime.pyx
    pandas/_libs/tslibs/timedeltas.pyx
    pandas/_libs/tslibs/timestamps.pyx
    pandas/_libs/tslibs/timezones.pyx
    pandas/_libs/writers.pyx
    pandas/io/sas/sas.pyx

    CYTHON_CPP
    pandas/_libs/window.pyx
    pandas/io/msgpack/_packer.pyx
    pandas/io/msgpack/_unpacker.pyx

    pandas/__init__.py
    pandas/_libs/__init__.py
    pandas/_libs/tslibs/__init__.py
    pandas/_version.py
    pandas/api/__init__.py
    pandas/api/extensions/__init__.py
    pandas/api/types/__init__.py
    pandas/arrays/__init__.py
    pandas/compat/__init__.py
    pandas/compat/chainmap.py
    pandas/compat/chainmap_impl.py
    pandas/compat/numpy/__init__.py
    pandas/compat/numpy/function.py
    pandas/compat/pickle_compat.py
    pandas/core/__init__.py
    pandas/core/accessor.py
    pandas/core/algorithms.py
    pandas/core/api.py
    pandas/core/apply.py
    pandas/core/arrays/__init__.py
    pandas/core/arrays/_ranges.py
    pandas/core/arrays/array_.py
    pandas/core/arrays/base.py
    pandas/core/arrays/categorical.py
    pandas/core/arrays/datetimelike.py
    pandas/core/arrays/datetimes.py
    pandas/core/arrays/integer.py
    pandas/core/arrays/interval.py
    pandas/core/arrays/numpy_.py
    pandas/core/arrays/period.py
    pandas/core/arrays/sparse.py
    pandas/core/arrays/timedeltas.py
    pandas/core/base.py
    pandas/core/categorical.py
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
    pandas/core/computation/pytables.py
    pandas/core/computation/scope.py
    pandas/core/config.py
    pandas/core/config_init.py
    pandas/core/dtypes/__init__.py
    pandas/core/dtypes/api.py
    pandas/core/dtypes/base.py
    pandas/core/dtypes/cast.py
    pandas/core/dtypes/common.py
    pandas/core/dtypes/concat.py
    pandas/core/dtypes/dtypes.py
    pandas/core/dtypes/generic.py
    pandas/core/dtypes/inference.py
    pandas/core/dtypes/missing.py
    pandas/core/frame.py
    pandas/core/generic.py
    pandas/core/groupby/__init__.py
    pandas/core/groupby/base.py
    pandas/core/groupby/categorical.py
    pandas/core/groupby/generic.py
    pandas/core/groupby/groupby.py
    pandas/core/groupby/grouper.py
    pandas/core/groupby/ops.py
    pandas/core/index.py
    pandas/core/indexes/__init__.py
    pandas/core/indexes/accessors.py
    pandas/core/indexes/api.py
    pandas/core/indexes/base.py
    pandas/core/indexes/category.py
    pandas/core/indexes/datetimelike.py
    pandas/core/indexes/datetimes.py
    pandas/core/indexes/frozen.py
    pandas/core/indexes/interval.py
    pandas/core/indexes/multi.py
    pandas/core/indexes/numeric.py
    pandas/core/indexes/period.py
    pandas/core/indexes/range.py
    pandas/core/indexes/timedeltas.py
    pandas/core/indexing.py
    pandas/core/internals/__init__.py
    pandas/core/internals/arrays.py
    pandas/core/internals/blocks.py
    pandas/core/internals/concat.py
    pandas/core/internals/construction.py
    pandas/core/internals/managers.py
    pandas/core/missing.py
    pandas/core/nanops.py
    pandas/core/ops.py
    pandas/core/panel.py
    pandas/core/resample.py
    pandas/core/reshape/__init__.py
    pandas/core/reshape/api.py
    pandas/core/reshape/concat.py
    pandas/core/reshape/melt.py
    pandas/core/reshape/merge.py
    pandas/core/reshape/pivot.py
    pandas/core/reshape/reshape.py
    pandas/core/reshape/tile.py
    pandas/core/reshape/util.py
    pandas/core/series.py
    pandas/core/sorting.py
    pandas/core/sparse/__init__.py
    pandas/core/sparse/api.py
    pandas/core/sparse/frame.py
    pandas/core/sparse/scipy_sparse.py
    pandas/core/sparse/series.py
    pandas/core/strings.py
    pandas/core/tools/__init__.py
    pandas/core/tools/datetimes.py
    pandas/core/tools/numeric.py
    pandas/core/tools/timedeltas.py
    pandas/core/util/__init__.py
    pandas/core/util/hashing.py
    pandas/core/window.py
    pandas/errors/__init__.py
    pandas/io/__init__.py
    pandas/io/api.py
    pandas/io/clipboard/__init__.py
    pandas/io/clipboard/clipboards.py
    pandas/io/clipboard/exceptions.py
    pandas/io/clipboard/windows.py
    pandas/io/clipboards.py
    pandas/io/common.py
    pandas/io/date_converters.py
    pandas/io/excel.py
    pandas/io/feather_format.py
    pandas/io/formats/__init__.py
    pandas/io/formats/console.py
    pandas/io/formats/css.py
    pandas/io/formats/csvs.py
    pandas/io/formats/excel.py
    pandas/io/formats/format.py
    pandas/io/formats/html.py
    pandas/io/formats/latex.py
    pandas/io/formats/printing.py
    pandas/io/formats/style.py
    pandas/io/formats/terminal.py
    pandas/io/gbq.py
    pandas/io/gcs.py
    pandas/io/html.py
    pandas/io/json/__init__.py
    pandas/io/json/json.py
    pandas/io/json/normalize.py
    pandas/io/json/table_schema.py
    pandas/io/msgpack/__init__.py
    pandas/io/msgpack/_version.py
    pandas/io/msgpack/exceptions.py
    pandas/io/packers.py
    pandas/io/parquet.py
    pandas/io/parsers.py
    pandas/io/pickle.py
    pandas/io/pytables.py
    pandas/io/s3.py
    pandas/io/sas/__init__.py
    pandas/io/sas/sas7bdat.py
    pandas/io/sas/sas_constants.py
    pandas/io/sas/sas_xport.py
    pandas/io/sas/sasreader.py
    pandas/io/sql.py
    pandas/io/stata.py
    pandas/plotting/__init__.py
    pandas/plotting/_compat.py
    pandas/plotting/_converter.py
    pandas/plotting/_core.py
    pandas/plotting/_misc.py
    pandas/plotting/_style.py
    pandas/plotting/_timeseries.py
    pandas/plotting/_tools.py
    pandas/testing.py
    pandas/tseries/__init__.py
    pandas/tseries/api.py
    pandas/tseries/converter.py
    pandas/tseries/frequencies.py
    pandas/tseries/holiday.py
    pandas/tseries/offsets.py
    pandas/tseries/plotting.py
    pandas/util/__init__.py
    pandas/util/_decorators.py
    pandas/util/_depr_module.py
    pandas/util/_doctools.py
    pandas/util/_exceptions.py
    pandas/util/_print_versions.py
    pandas/util/_test_decorators.py
    pandas/util/_tester.py
    pandas/util/_validators.py
    pandas/util/testing.py
)

RESOURCE_FILES(
    PREFIX contrib/python/pandas/py2/
    .dist-info/METADATA
    .dist-info/top_level.txt
    pandas/io/formats/templates/html.tpl
)

END()
