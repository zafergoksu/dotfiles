# {{PROJECT_NAME}}

A C++23 project (library + app) built with CMake and Conan 2, tested with GoogleTest.

## Layout

| Path | Purpose |
|------|---------|
| `include/{{PROJECT_NS}}/` | Public library headers |
| `src/` | Library implementation (`{{PROJECT_NS}}` target) |
| `app/` | Executable that links the library (`{{PROJECT_SLUG}}` target) |
| `tests/` | GoogleTest suite (`{{PROJECT_NS}}_tests` target) |

## Prerequisites

- CMake >= 3.26 and Ninja
- Conan 2 (`pipx install conan`); run `conan profile detect` if you have no profile
- A C++23 compiler (recent Clang or GCC)

## Build & test

```bash
# 1. Resolve dependencies and generate the CMake toolchain + presets.
conan install . --build=missing -s build_type=Debug

# 2. Configure / build / test via the Conan-generated preset.
cmake --preset conan-debug
cmake --build --preset conan-debug
ctest --preset conan-debug --output-on-failure
```

Run the app:

```bash
./build/Debug/bin/{{PROJECT_SLUG}}
```

For a release build, swap `Debug` -> `Release` and `conan-debug` -> `conan-release`.

> **C++ standard note:** CMake pins this project to C++23. If your Conan profile
> sets a lower `compiler.cppstd` (e.g. `gnu20`), dependencies still build fine;
> to align them, add `-s compiler.cppstd=gnu23` to the `conan install` command.

## Formatting

Code style lives in `.clang-format` (Google base). Format everything in place:

```bash
find app src tests include -name '*.cpp' -o -name '*.hpp' \
  | xargs clang-format --style=file -i
```

## Continuous integration

`.github/workflows/ci.yml` runs two jobs on every PR to `main` (and on pushes to
`main`): a **clang-format** check and a **build & test** job. To make them block
merges, enable branch protection on `main` (GitHub → Settings → Branches → add
rule for `main`) and mark `clang-format` and `build & test` as required status
checks.
