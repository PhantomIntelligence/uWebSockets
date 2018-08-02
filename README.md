# uws  -  µWebSocket, *à la* Phantom

This repo is an adaptation of [µWebSocket](https://github.com/uNetworking/uWebSockets).  
It has been made to enable the compilation of uws with CMake, which is no longer supported by the author.  
[This post](https://pabloariasal.github.io/2018/02/19/its-time-to-do-cmake-right/) has been a very useful resource during the adaptation.  

## Dependencies  

Note that this project has some dependencies:  
  * cmake    
  * libuv  
  * pthread  
  * pkgConfig  
  * openssl  
  * zlib  


## Installation  

First, make sure all the dependencies are installed.  
1. Download the project  
2. In the base `uws/` directory, run :    
```
mkdir cmake-build-debug  
cd cmake-build-debug  
cmake -DCMAKE_BUILD_TYPE=Debug -G "CodeBlocks - UnixMakefile" ..  
make && sudo make install  
```  

## Integration in other CMake projects
If everything goes according to plan, you should then be able to include the `uws` by adding this to your `CMakeLists.txt`:  
```
find_package(uws CONFIG REQUIRED)
if (uws_FOUND)
    message(STATUS "Found uWS")
    message(STATUS "LIBRARIES ${uws_LIBRARIES}")
    message(STATUS "INCLUDE_DIRS ${uws_INCLUDE_DIRS}")
else ()
    message(FATAL "uWS is required")
endif ()

include_directories(${uws_INCLUDE_DIRS})

target_link_libraries(**YOUR TARGET NAME HERE!!**  ${uws_LIBRARIES})

```
