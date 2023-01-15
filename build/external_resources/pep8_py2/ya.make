RESOURCES_LIBRARY()



IF (NOT HOST_OS_DARWIN AND NOT HOST_OS_LINUX AND NOT HOST_OS_WINDOWS)
    MESSAGE(FATAL_ERROR Unsupported host platform for PEP8_PY2)
ENDIF()

DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE(
    PEP8_PY2
    sbr:1387579290 FOR DARWIN
    sbr:1589284013 FOR LINUX-PPC64LE
    sbr:1387579700 FOR LINUX
    sbr:1387579483 FOR WIN32
)

END()
