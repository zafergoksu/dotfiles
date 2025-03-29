# Consuming Packages

## Setup and install packages

```
conan install . -s build_type=Debug --build=missing

conan install . -s build_type=Release --build=missing
```

## Configure presets

```
cmake --preset conan-debug
cmake --preset conan-release
```

## Build project

```
cmake --build --preset conan-debug
cmake --build --preset conan-release
```

## Ensure compile_commands.json

```
bear -- cmake --build --preset conan-debug
bear -- cmake --build --preset conan-release
```

## Aliases
```
alias mdb="cmake --build --preset conan-debug"
alias mr="cmake --build --preset conan-release"
```
