add_executable(example main.cpp)

find_package(uws REQUIRED)

target_link_libraries(example ${uws_LIBRARIES})

install(TARGETS example
        EXPORT ${PROJECT_NAME}Targets
        RUNTIME DESTINATION "${INSTALL_BIN_DIR}" COMPONENT bin)
