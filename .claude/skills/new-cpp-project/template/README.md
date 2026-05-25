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

## Quick start (make)

A `Makefile` wraps the full workflow:

```bash
make              # configure (if needed) + build   [Debug]
make test         # build + run the test suite
make run          # build + run the app
make format       # clang-format every source in place
make format-check # clang-format dry-run (what CI enforces)
make clean        # remove the build tree + generated presets
```

Release builds: append `BUILD_TYPE=Release` to any target, e.g.
`make test BUILD_TYPE=Release`.

> **First build of a config may take a minute.** `conan install --build=missing`
> compiles any dependency (e.g. GoogleTest) that has no cached binary for your
> profile. It can look quiet, but it is building, not hung — later builds reuse
> the Conan cache and start instantly.

### What each target runs

| `make` target | Equivalent commands |
|---------------|---------------------|
| `make` / `make build` | `conan install . --build=missing -s build_type=Debug`<br>`cmake --preset conan-debug`<br>`cmake --build --preset conan-debug` |
| `make test` | *(build, then)* `ctest --preset conan-debug --output-on-failure` |
| `make run` | *(build, then)* `./build/Debug/bin/{{PROJECT_SLUG}}` |
| `make format` | `clang-format --style=file -i` over `app/ src/ tests/ include/` |
| `make format-check` | the same with `--dry-run --Werror` |
| `make clean` | `rm -rf build CMakeUserPresets.json` |

For `BUILD_TYPE=Release`, swap `Debug` -> `Release` and `conan-debug` -> `conan-release`.

## Build & test (manual)

The same steps without `make`:

```bash
# 1. Resolve dependencies and generate the CMake toolchain + presets.
conan install . --build=missing -s build_type=Debug
#    (run `conan profile detect` once first if you have no Conan profile)

# 2. Configure, build, and test via the Conan-generated preset.
cmake --preset conan-debug
cmake --build --preset conan-debug
ctest --preset conan-debug --output-on-failure

# 3. Run the app.
./build/Debug/bin/{{PROJECT_SLUG}}
```

For a release build, swap `Debug` -> `Release` and `conan-debug` -> `conan-release`.

Build outputs:

| Artifact | Path |
|----------|------|
| App | `build/Debug/bin/{{PROJECT_SLUG}}` |
| Library | `build/Debug/src/lib{{PROJECT_NS}}.a` |
| Tests | `build/Debug/bin/{{PROJECT_NS}}_tests` |

> **C++ standard note:** CMake pins this project to C++23. If your Conan profile
> sets a lower `compiler.cppstd` (e.g. `gnu20`), dependencies still build fine;
> to align them, add `-s compiler.cppstd=gnu23` to the `conan install` command.

## Formatting

Code style lives in `.clang-format` (Google base). Use `make format` /
`make format-check`, or call clang-format directly:

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
