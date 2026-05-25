find_package(GTest REQUIRED)

add_executable({{PROJECT_NS}}_tests
    test_greeting.cpp)

target_link_libraries({{PROJECT_NS}}_tests
    PRIVATE
        {{PROJECT_NS}}::{{PROJECT_NS}}
        GTest::gtest_main
        project_warnings)

include(GoogleTest)
gtest_discover_tests({{PROJECT_NS}}_tests)
