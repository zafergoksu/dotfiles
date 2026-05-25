---
name: sync-dotfiles
description: Use when the user wants to sync, save, or push their local dotfile/config changes (alacritty, nvim, tmux, fish, kitty, sway, waybar, zsh, etc.) from $HOME into their dotfiles git repo. Triggers like "sync my dotfiles", "push my config changes", "update my dotfiles repo".
---

# Sync Dotfiles

## Overview

Mirrors the user's live configs from `$HOME` into their dotfiles git repo, then
commits and pushes. Only a curated manifest of configs is synced — the ones the
repo already tracks (alacritty, bspwm, dunst, fish, kitty, nvim, picom, polybar,
rofi, sway, sxhkd, waybar, plus home-level `.tmux.conf`, `.tmux/`, `.zshrc`,
`.zprofile`, `.gitconfig`, `.Xresources`, `.ideavimrc`, `.local/bin/zafer/`,
`.conan2/profiles/`, `.claude/skills/`). Nothing outside the manifest is ever
touched.

The worker is `sync.sh` (in this skill dir). It mirrors with `rsync --delete`, so
the repo ends up exactly matching the live config: new files added, changed files
updated, locally-deleted files removed. Plugin/cache/session noise (`.git`,
`.claude`, `docs`, `plugins`, swap files) is excluded.

## Workflow

1. **Stage and review (never push blind):**
   ```bash
   ~/.claude/skills/sync-dotfiles/sync.sh
   ```
   This mirrors configs into the repo, stages them, and prints `git diff --stat`
   + `git status --short`. Nothing is committed or pushed yet.

2. **Show the user the change summary** and get confirmation to push.

3. **Push** once confirmed:
   ```bash
   ~/.claude/skills/sync-dotfiles/sync.sh --push
   ```
   Re-mirrors (idempotent), commits with an auto-generated message listing the
   changed configs, and pushes to the current branch.

## Adding a new config

Add one line to the `DIRS` (directory) or `FILES` (single file) array in
`sync.sh`. The path is relative to `$HOME`. The repo mirrors the `$HOME`
structure, so a config at `~/.config/foo` is tracked at `.config/foo` in the repo.

## Notes

- `.clang-format`, `.clang-tidy`, `.conan2/notes.md` are tracked in the repo but
  have no live source in `$HOME` (they're repo-local templates/notes) — the
  script skips missing sources with a warning, so they're left alone.
- Override the repo location with `DOTFILES_REPO=/path/to/repo`.
- The exclude list (`docs`, `.claude`, `plugins`) is global across managed trees.
  If a future config legitimately needs one of those dirs tracked, adjust the
  `EXCLUDES` array in `sync.sh`.
- `.claude/skills/` is tracked even though `.claude` is in `EXCLUDES`: rsync
  matches exclude patterns relative to each entry's own transfer root, so when
  `.claude/skills` is mirrored the `.claude` pattern matches nothing inside it.
  This is what tracks personal skills (sync-dotfiles, new-cpp-project) in the
  repo. A skill that adds a top-level `docs/` or `plugins/` dir would have it
  silently dropped by the global excludes.
