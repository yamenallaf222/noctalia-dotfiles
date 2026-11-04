#!/usr/bin/env bash
# Link this repo's configs into ~/.config. Existing folders are backed up first.
# Usage: ./install.sh   (safe to run again)
set -euo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HOME/.config"

for name in hypr noctalia; do
    target="$HOME/.config/$name"
    if [ "$(readlink -f "$target")" = "$repo/$name" ]; then
        echo "ok      $target"
        continue
    fi
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup="$target.bak-$(date +%Y%m%d-%H%M%S)"
        mv "$target" "$backup"
        echo "backup  $target -> $backup"
    fi
    ln -s "$repo/$name" "$target"
    echo "linked  $target -> $repo/$name"
done
