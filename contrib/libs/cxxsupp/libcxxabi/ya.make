# Generated by devtools/yamaker from nixpkgs bc3039dffce5b064958a10619a95ebca36d707e1.

LIBRARY()



VERSION(2021-06-07-87039c048c0cbc3d8cbba86187269b006bf2f373)

ORIGINAL_SOURCE(https://github.com/llvm/llvm-project/archive/87039c048c0cbc3d8cbba86187269b006bf2f373.tar.gz)

LICENSE(
    Apache-2.0 WITH LLVM-exception
    MIT
    NCSA
)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

ADDINCL(
    contrib/libs/cxxsupp/libcxxabi/include
    contrib/libs/cxxsupp/libcxx
    contrib/libs/cxxsupp/libcxx/include
)

NO_COMPILER_WARNINGS()

NO_RUNTIME()

NO_UTIL()

CFLAGS(-D_LIBCXXABI_BUILDING_LIBRARY)

SRCS(
    src/abort_message.cpp
    src/cxa_aux_runtime.cpp
    src/cxa_default_handlers.cpp
    src/cxa_demangle.cpp
    src/cxa_exception.cpp
    src/cxa_exception_storage.cpp
    src/cxa_guard.cpp
    src/cxa_handlers.cpp
    src/cxa_personality.cpp
    src/cxa_vector.cpp
    src/cxa_virtual.cpp
    src/fallback_malloc.cpp
    src/private_typeinfo.cpp
    src/stdlib_exception.cpp
    src/stdlib_new_delete.cpp
    src/stdlib_stdexcept.cpp
    src/stdlib_typeinfo.cpp
)

SRC_CPP_PIC(
    src/cxa_thread_atexit.cpp
    -fno-lto
)

END()
