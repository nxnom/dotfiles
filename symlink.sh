#!/bin/sh

current_dir="$(pwd)"

dotfiles=(
  alacritty
  i3
  kitty
  nvim
  tmux
  zsh
)

for dotfile in "${dotfiles[@]}"; do
  echo "Creating symlink to $dotfile in .config directory."
  ln -s "$current_dir/$dotfile" "$HOME/.config/$dotfile -f"
done

echo "Creating symlink to rubocop in .config directory."
ln -s "$current_dir/nvim/configs/rubocop" "$HOME/.config/rubocop"

echo "Creating symlink to .eslintrc.js in home directory."
ln -s "$current_dir/nvim/configs/.eslintrc.js" "$HOME/.eslintrc.js"
