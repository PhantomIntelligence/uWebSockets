configure_file(config.h.in "${CMAKE_CURRENT_BINARY_DIR}/config.h" @ONLY)

file(GLOB SOURCE_FILES "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")
file(GLOB HEADER_FILES "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h")

add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES} config.h.in)
#add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

target_include_directories(${PROJECT_NAME}
        PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
        )

####### Dependencies ######################################

### LibUV
find_package(LibUV REQUIRED)
include_directories(${LIBUV_INCLUDE_DIRS})

### PThread
find_package(Threads REQUIRED)

### OpenSSL
find_package(PkgConfig REQUIRED)
pkg_search_module(OPENSSL REQUIRED openssl)
if (OPENSSL_FOUND)
    include_directories(${OPENSSL_INCLUDE_DIRS})
    message(STATUS "Using OpenSSL ${OPENSSL_VERSION}")
else ()
    message(FATAL "OpenSSL not found")
endif ()

### ZLIB
find_package(ZLIB REQUIRED)

target_compile_options(${PROJECT_NAME}
        PUBLIC
        -Werror
        -DUSE_LIBUV ### -> LibUV
        )

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_11)

target_link_libraries(${PROJECT_NAME}
        PUBLIC
        ${LIBUV_LIBRARIES}
        ${CMAKE_THREAD_LIB_INIT}
        ${OPENSSL_LIBRARIES}
        ${ZLIB_LIBRARIES}
        )

install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}Targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        )

