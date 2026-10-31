add_executable({{PROJECT_SLUG}}
    main.cpp)

target_link_libraries({{PROJECT_SLUG}}
    PRIVATE
        {{PROJECT_NS}}::{{PROJECT_NS}}
        project_warnings)
