#!/usr/bin/env zsh

current_dir="$(pwd)"

dotfiles=(
  alacritty
  i3
  kitty
  nvim
  tmux
  zsh
  foot
)

for dotfile in "${dotfiles[@]}"; do
  echo "Creating symlink to $dotfile in .config directory."
  ln -sf "$current_dir/$dotfile" "$HOME/.config"
done

echo "Creating symlink to rubocop in .config directory."
ln -sf "$current_dir/nvim/configs/rubocop" "$HOME/.config"

echo "Creating symlink to .eslintrc.js in home directory."
ln -sf "$current_dir/nvim/configs/.eslintrc.js" "$HOME"
