macro(fetch_uws _download_module_path _download_root)
    message(STATUS)
    message(STATUS "Building uws")
    message(STATUS "uws download directory: ${_download_root}")
    set(UWS_DOWNLOAD_ROOT ${_download_root})
    configure_file(
            ${_download_module_path}/uws-download.cmake.in
            ${_download_root}/CMakeLists.txt
            @ONLY
    )
    unset(UWS_DOWNLOAD_ROOT)

    execute_process(
            COMMAND
            "${CMAKE_COMMAND}" -G "${CMAKE_GENERATOR}" .
            WORKING_DIRECTORY
            ${_download_root}
    )
    execute_process(
            COMMAND
            "${CMAKE_COMMAND}" --build .
            WORKING_DIRECTORY
            ${_download_root}
    )

    # adds the target: uws
    add_subdirectory(
            ${_download_root}/uws-src
            ${_download_root}/uws-build
    )

    set_property(TARGET uws APPEND_STRING PROPERTY COMPILE_FLAGS " -std=c++11 -O3")
    message(STATUS "Done with uws")
    message(STATUS)
endmacro()
