

RECURSE(
    accurate_accumulate
    accurate_accumulate/benchmark
    accurate_accumulate/benchmark/metrics
    archive/ut
    binsaver
    binsaver/ut
    binsaver/ut_util
    blockcodecs
    blockcodecs/fuzz
    build_info
    cache
    cgiparam
    cgiparam/fuzz
    cgiparam/ut
    charset
    charset/ut
    chromium_trace
    colorizer
    colorizer/ut
    containers
    coroutine
    cppparser
    cpuid_check
    dbg_output
    dbg_output/ut
    deprecated
    diff
    diff/ut
    digest
    dns
    dns/ut
    dot_product
    dot_product/bench
    dot_product/ut
    enumbitset
    enumbitset/ut
    fast_exp
    fast_exp/benchmark
    fast_exp/ut
    fast_log
    float16
    float16/ut
    getopt
    getopt/last_getopt_demo
    getopt/small
    getopt/ut
    grid_creator
    grid_creator/fuzz
    grid_creator/ut
    hnsw
    http
    json
    json/fast_sax
    json/flex_buffers
    json/flex_buffers/ut
    json/fuzzy_test
    json/ut
    json/writer/ut
    json/yson
    json/yson/ut
    l1_distance
    l1_distance/bench
    l1_distance/ut
    l2_distance
    l2_distance/bench
    l2_distance/ut
    langmask
    langmask/proto
    langmask/serialization
    langmask/ut
    langs
    langs/ut
    lcs
    lcs/ut
    lfalloc
    lfalloc/dbg
    lfalloc/dbg_info
    lfalloc/yt
    linear_regression
    linear_regression/benchmark
    linear_regression/ut
    logger
    logger/global
    logger/global/ut
    logger/ut
    malloc
    neh
    neh/asio/ut
    neh/ut
    netliba
    object_factory
    object_factory/ut
    on_disk
    online_hnsw
    openssl
    packers
    packers/ut
    par
    pop_count
    pop_count/benchmark
    pop_count/ut
    resource
    resource/ut
    sse
    statistics
    statistics/ut
    streams
    string_utils
    svnversion
    terminate_handler
    terminate_handler/sample
    testing
    text_processing
    threading
    token
    token/lite
    token/serialization
    token/serialization/ut
    token/ut
    tokenizer
    tokenizer/ut
    yson
    yson/json
    yson/node
    yson/node/pybind
    yt
)

IF (OS_LINUX)
    RECURSE(
    ytalloc
)
ENDIF()

IF (OS_WINDOWS)
    RECURSE(
    
)
ELSE()
    RECURSE(
    sse/ut
)
ENDIF()

IF (HAVE_CUDA)
    RECURSE(
    cuda
)
ENDIF()
