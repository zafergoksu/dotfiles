#include <gtest/gtest.h>

#include "{{PROJECT_NS}}/{{PROJECT_NS}}.hpp"

TEST(Greeting, IsNotEmpty)
{
    EXPECT_FALSE({{PROJECT_NS}}::greeting().empty());
}
