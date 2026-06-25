#!/bin/bash

# Absolute path of the script (works from any directory)
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"

# List of configs to link
configs=(
  hypr
  kitty
  nvim
  nvim_old
  rofi
  waybar
  zathura
)

echo "Dotfiles dir: $DOTFILES"
echo "Config dir:   $CONFIG"
echo ""

for config in "${configs[@]}"; do
  src="$DOTFILES/$config"
  dst="$CONFIG/$config"

  if [ ! -d "$src" ]; then
    echo "SKIP $config — not found in dotfiles"
    continue
  fi

  if [ -L "$dst" ]; then
    rm "$dst"
    echo "LINK $config — replacing existing symlink"
  elif [ -d "$dst" ]; then
    echo "SKIP $config — already exists as a real directory, remove it manually to replace"
    continue
  fi

  ln -s "$src" "$dst"
  echo "OK   $config — linked"
done

echo ""
echo "Done, Salu2!!"
