# uws  -  µWebSocket, *à la* Phantom

This repo is an adaptation of [µWebSocket](https://github.com/uNetworking/uWebSockets).  
It has been made to enable the compilation of uws with CMake, which is no longer supported by the author.  
[This post](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/) has been a very useful resource during the adaptation for the CMake build process.  
Other files have been created to help the integration of `uws` to any other CMake project (Located in the `cmake-files-for-other-projects-using-uws` folder)  
[Googletest's cmake integration page](https://github.com/google/googletest/blob/master/googletest/README.md#using-cmake) has been particularly useful for this part.  

## Dependencies  

Note that this project has some dependencies:  
  * cmake    
  * libuv  
  * pthread  
  * pkgConfig  
  * openssl  
  * zlib  

Make sure all the dependencies are installed, otherwise `uws` won't be built!

## Integration...
### with CMake doing almost all the work (recommended)
#### Add the helper CMake macros to your project
Copy the content of the `cmake-files-for-other-projects-using-uws` folder to the root of your CMake project.

> NB:
> 1. You can actually place this `cmake-module` folder wherever you like, although we recommend the project's root directory for simplicity and cleanness.  
> 2. You can always rename `cmake-module` and the other macros to something else, but make sure to rename them in every files!


It contains cmake macros to simplify the integration of a git project in CMake.
Then, add the following lines to your root `CMakeLists.txt` somewhere near the top:
```
...  
# Integration of cmake macros and custom functions
include(cmake-module/setupCMakeMacros.cmake)
setup_cmake_macros(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})
...  
```
You can take a look in the `cmake-module/setupCMakeMacros.cmake` to know what exactly gets loaded.

#### Call the macro that integrate uws
You can then drop those lines where you build your CMake target:  
```
# uws
fetch_uws(
        ${PROJECT_SOURCE_DIR}/cmake-module
        ${PROJECT_BINARY_DIR}/lib/uws
)
target_link_libraries(${PROJECT_NAME} ... uws)
```

... and your done!


### Manual installation and integration
#### Installation  

1. Download the project
2. In the base `uws/` directory, run :
```
mkdir cmake-build-debug
cd cmake-build-debug
cmake -DCMAKE_BUILD_TYPE=Debug -G "CodeBlocks - UnixMakefile" ..
make && sudo make install
```
#### Integration in other CMake projects
If everything goes according to plan, you should then be able to include the `uws` by adding this to your `CMakeLists.txt`:  
```
find_package(uws CONFIG REQUIRED)
if (uws_FOUND)
    message(STATUS "Found uws")
    message(STATUS "uws libraries path: ${uws_LIBRARIES}")
    message(STATUS "uws headers directory: ${uws_INCLUDE_DIRS}")
else ()
    message(FATAL "uws is required")
endif ()

include_directories(${uws_INCLUDE_DIRS})

target_link_libraries(**YOUR TARGET NAME HERE!!**  uws)

```

## License
Apache-2.0
