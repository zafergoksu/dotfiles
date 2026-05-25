#!/usr/bin/env bash
#
# new-cpp-project: scaffold a C++23 library+app project
# (CMake + Conan 2 + GoogleTest).
#
# Usage:
#   scaffold.sh <name> [target-dir]   # create <target-dir> (default ./<slug>)
#   scaffold.sh --here <name>         # scaffold into the current directory
#
# <name> may be given in any case; it is normalised into:
#   PROJECT_SLUG   kebab-case   dir / repo / CMake project / executable name
#   PROJECT_NS     snake_case   C++ namespace + library/test CMake targets
#   PROJECT_CLASS  PascalCase   Conan recipe class name
#   PROJECT_NAME   the raw name display string (README / description)
#
# Never overwrites existing files. Initialises git (unless already a repo)
# and makes the first commit.

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$SKILL_DIR/template"

HERE=0
if [ "${1:-}" = "--here" ]; then
  HERE=1
  shift
fi

NAME="${1:-}"
if [ -z "$NAME" ]; then
  echo "usage: scaffold.sh [--here] <name> [target-dir]" >&2
  exit 1
fi

# --- Normalise the name into its variants -----------------------------------
SLUG="$(printf '%s' "$NAME" \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//')"
if [ -z "$SLUG" ]; then
  echo "error: '$NAME' contains no usable [a-z0-9] characters" >&2
  exit 1
fi
NS="$(printf '%s' "$SLUG" | tr '-' '_')"
CLASS="$(printf '%s' "$SLUG" | sed -E 's/(^|-)([a-z0-9])/\U\2/g')"

# --- Resolve the target directory -------------------------------------------
if [ "$HERE" -eq 1 ]; then
  TARGET="$(pwd)"
else
  TARGET="${2:-$(pwd)/$SLUG}"
  mkdir -p "$TARGET"
  if [ -n "$(ls -A "$TARGET" 2>/dev/null)" ]; then
    echo "error: $TARGET is not empty (use --here to scaffold into it anyway)" >&2
    exit 1
  fi
fi
TARGET="$(cd "$TARGET" && pwd)"

# --- Stage the template, substitute placeholders, then install --------------
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
cp -a "$TEMPLATE_DIR/." "$STAGE/"

# gitignore is stored without a leading dot so it does not act as ignore
# rules inside the skill repo; restore the real name now.
[ -f "$STAGE/gitignore" ] && mv "$STAGE/gitignore" "$STAGE/.gitignore"

# Rename any path component carrying the namespace placeholder. Handle one
# entry at a time, deepest-first, substituting only the basename, so a parent
# rename never invalidates a not-yet-processed child path.
while :; do
  path="$(find "$STAGE" -depth -name '*__PROJECT_NS__*' | head -n1)"
  [ -z "$path" ] && break
  dir="$(dirname "$path")"
  base="$(basename "$path")"
  mv "$path" "$dir/${base//__PROJECT_NS__/$NS}"
done

# Escape replacement strings for sed (delimiter '|', plus & and backslash).
esc() { printf '%s' "$1" | sed -e 's/[&|\\]/\\&/g'; }
e_slug="$(esc "$SLUG")"; e_ns="$(esc "$NS")"
e_class="$(esc "$CLASS")"; e_name="$(esc "$NAME")"

grep -rIlZ -F '{{PROJECT_' "$STAGE" | while IFS= read -r -d '' f; do
  sed -i \
    -e "s|{{PROJECT_SLUG}}|$e_slug|g" \
    -e "s|{{PROJECT_NS}}|$e_ns|g" \
    -e "s|{{PROJECT_CLASS}}|$e_class|g" \
    -e "s|{{PROJECT_NAME}}|$e_name|g" \
    "$f"
done

# Refuse to clobber any pre-existing file in the target.
conflicts=()
while IFS= read -r src; do
  rel="${src#"$STAGE"/}"
  [ -e "$TARGET/$rel" ] && conflicts+=("$rel")
done < <(find "$STAGE" -type f)
if [ "${#conflicts[@]}" -gt 0 ]; then
  echo "error: refusing to overwrite existing files in $TARGET:" >&2
  printf '  %s\n' "${conflicts[@]}" >&2
  exit 1
fi

cp -a "$STAGE/." "$TARGET/"

# --- Initialise git and make the first commit -------------------------------
cd "$TARGET"
if [ -d .git ]; then
  echo "note: existing git repo detected -- not re-initialising."
else
  git init -q
fi
git add -A
if git diff --cached --quiet; then
  echo "note: nothing to commit."
else
  git commit -q -m "scaffold $SLUG: C++23 library+app (CMake + Conan 2 + GoogleTest)"
fi

cat <<EOF

Scaffolded '$SLUG' in $TARGET

Next steps:
  cd $TARGET
  conan install . --build=missing -s build_type=Debug
  cmake --preset conan-debug
  cmake --build --preset conan-debug
  ctest --preset conan-debug --output-on-failure
EOF
