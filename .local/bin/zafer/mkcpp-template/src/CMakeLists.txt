add_library({{PROJECT_NS}}
    {{PROJECT_NS}}.cpp)
add_library({{PROJECT_NS}}::{{PROJECT_NS}} ALIAS {{PROJECT_NS}})

target_include_directories({{PROJECT_NS}}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>)

target_link_libraries({{PROJECT_NS}} PRIVATE project_warnings)
