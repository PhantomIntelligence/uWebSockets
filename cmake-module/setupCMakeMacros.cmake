
macro(setup_cmake_macros _source_dir _binary_dir)

    set(CMAKE_MACRO_SOURCE_DIR ${_source_dir})
    set(CMAKE_MACRO_BINARY_DIR ${_binary_dir})

    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake-module/")

endmacro()
