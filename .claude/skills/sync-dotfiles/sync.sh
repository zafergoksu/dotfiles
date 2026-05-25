#!/usr/bin/env bash
#
# sync-dotfiles: mirror live configs from $HOME into the dotfiles repo.
#
# Only the curated manifest below is touched. Each entry is mirrored with
# `rsync --delete` so the repo exactly matches the live config: new files are
# added, changed files updated, and locally-deleted files removed. The exclude
# list keeps plugin/cache/session noise out.
#
# Usage:
#   sync.sh           # mirror + stage changes, print a summary, DO NOT push
#   sync.sh --push    # mirror + stage + commit + push to the current branch
#
# Override the repo location with DOTFILES_REPO=/path/to/repo.

set -euo pipefail

REPO="${DOTFILES_REPO:-$HOME/git-repositories/dotfiles}"
PUSH=0
[ "${1:-}" = "--push" ] && PUSH=1

if [ ! -d "$REPO/.git" ]; then
  echo "error: $REPO is not a git repository (set DOTFILES_REPO)" >&2
  exit 1
fi

# --- Manifest: paths relative to $HOME that this repo manages ---------------
# Directories are mirrored recursively (with --delete).
DIRS=(
  .config/alacritty
  .config/bspwm
  .config/dunst
  .config/fish
  .config/kitty
  .config/nvim
  .config/picom
  .config/polybar
  .config/rofi
  .config/sway
  .config/sxhkd
  .config/waybar
  .tmux
  .local/bin/zafer
  .conan2/profiles
  .claude/skills
)

# Single files copied verbatim.
FILES=(
  .tmux.conf
  .zshrc
  .zprofile
  .gitconfig
  .Xresources
  .ideavimrc
)

# Tracked-in-repo but intentionally NOT synced (no live source in $HOME):
#   .clang-format, .clang-tidy  -> C++ project templates maintained in-repo
#   .conan2/notes.md            -> repo-local note

# --- Noise that should never be synced, anywhere in a managed tree ----------
EXCLUDES=(
  --exclude=.git
  --exclude=.claude
  --exclude=docs
  --exclude=plugins
  --exclude='*.swp'
  --exclude='*.swo'
  --exclude=.DS_Store
  --exclude=__pycache__
)

managed=()  # paths to stage afterwards

for d in "${DIRS[@]}"; do
  src="$HOME/$d"
  if [ ! -d "$src" ]; then
    echo "skip (missing): $d"
    continue
  fi
  mkdir -p "$REPO/$d"
  rsync -a --delete "${EXCLUDES[@]}" "$src/" "$REPO/$d/"
  managed+=("$d")
done

for f in "${FILES[@]}"; do
  src="$HOME/$f"
  if [ ! -f "$src" ]; then
    echo "skip (missing): $f"
    continue
  fi
  mkdir -p "$REPO/$(dirname "$f")"
  rsync -a "$src" "$REPO/$f"
  managed+=("$f")
done

cd "$REPO"
git add -A -- "${managed[@]}"

if git diff --cached --quiet; then
  echo "No changes to sync."
  exit 0
fi

echo
echo "=== Changes staged ==="
git diff --cached --stat
echo
git status --short

if [ "$PUSH" -eq 1 ]; then
  changed=$(git diff --cached --name-only \
    | sed -E 's#^\.config/##; s#/.*##; s#^\.##' \
    | sort -u | paste -sd', ' -)
  git commit -m "sync dotfiles: ${changed:-update}"
  git push
  echo
  echo "Pushed."
else
  echo
  echo "Staged only. Review above, then run with --push (or commit manually)."
fi
