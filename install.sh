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

# udev rules -> /etc/udev/rules.d (checked first; sudo only when something changed)
changed=0
for rule in "$repo"/udev/*.rules; do
    dest="/etc/udev/rules.d/$(basename "$rule")"
    if cmp -s "$rule" "$dest"; then
        echo "ok      $dest"
        continue
    fi
    udevadm verify --no-style "$rule" >/dev/null || { echo "invalid $rule"; exit 1; }
    sudo install -m 644 "$rule" "$dest"
    echo "copied  $dest"
    changed=1
done
if [ "$changed" = 1 ]; then
    sudo udevadm control --reload && sudo udevadm trigger
fi
