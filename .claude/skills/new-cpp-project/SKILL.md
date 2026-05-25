---
name: new-cpp-project
description: Use when the user wants to scaffold, bootstrap, or start a new C++ project/repo from scratch. Triggers like "set up a C++ project", "new cpp project", "scaffold a C++ library and app", "bootstrap a CMake/Conan project". Produces a C++23 library+app skeleton with CMake, Conan 2, GoogleTest, clang-format/tidy, and CI.
---

# New C++ Project

## Overview

Scaffolds a ready-to-build C++23 project using the user's toolchain: **CMake +
Conan 2 + GoogleTest**, with their **Google-style `.clang-format`**, `.clang-tidy`,
a `.gitignore`, README, and a GitHub Actions PR gate (clang-format + tests).

The worker is `scaffold.sh`. It copies the `template/` tree into the target
directory, substitutes the project name into file contents and paths, then
initialises git and makes the first commit.

## When to use

- Starting a brand-new C++ codebase or repo
- The user asks to "set up", "bootstrap", or "scaffold" a C++ project
- An empty (or freshly `git init`-ed) directory needs a build skeleton

Not for: adding CMake/Conan to a project that already has sources (this never
overwrites existing files and refuses non-empty targets unless `--here`).

## What it produces

```
<project>/
├── CMakeLists.txt            # C++23, warnings, src/app/tests subdirs
├── conanfile.py              # test_requires gtest; cmake_layout
├── .clang-format             # Google base, Allman braces, 80 col
├── .clang-tidy
├── .gitignore                # build/, Conan-generated files, etc.
├── README.md                 # build/test/format/CI instructions
├── .github/workflows/ci.yml  # PR gate: clang-format job + build & test job
├── include/<ns>/<ns>.hpp     # public library header
├── src/<ns>.cpp              # library target  <ns>  (alias <ns>::<ns>)
├── app/main.cpp              # executable target  <slug>  (links the library)
└── tests/test_greeting.cpp   # GoogleTest, gtest_discover_tests
```

The app and the tests both link the library, so the core logic is exercised
both ways.

## Usage

```bash
~/.claude/skills/new-cpp-project/scaffold.sh <name> [target-dir]
~/.claude/skills/new-cpp-project/scaffold.sh --here <name>   # into current dir
```

`<name>` is normalised into: `PROJECT_SLUG` (kebab — dir/repo/CMake project/exe),
`PROJECT_NS` (snake — C++ namespace + lib/test targets), `PROJECT_CLASS` (Pascal —
Conan recipe class), and `PROJECT_NAME` (raw display string).

Use `--here` to scaffold into an existing directory (e.g. a fresh repo that
already has `.git`); it won't re-init git, and it never overwrites existing files.

## After scaffolding

Tell the user the build flow (also in the generated README):

```bash
conan install . --build=missing -s build_type=Debug
cmake --preset conan-debug
cmake --build --preset conan-debug
ctest --preset conan-debug --output-on-failure
```

To make CI block merges, branch protection on `main` must mark the
`clang-format` and `build & test` checks as required (GitHub repo settings — not
something the scaffold can set).

## Editing the template

All scaffolded content lives in `template/`. Content placeholders are
`{{PROJECT_SLUG}}`, `{{PROJECT_NS}}`, `{{PROJECT_CLASS}}`, `{{PROJECT_NAME}}`.
Path components use the `__PROJECT_NS__` token (braces are awkward in paths).
The `.gitignore` is stored as `gitignore` (no dot) so it doesn't act as ignore
rules inside the skill repo; `scaffold.sh` restores the dotted name on copy.
