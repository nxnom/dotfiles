# Getting Started

This is just my notes on how to setup these dotfiles.

## Font

Download and install SpaceMono Nerd Font from [here](https://www.nerdfonts.com/font-downloads)

## Pre-requisites

- Set `XDG_CONFIG_HOME` to `$HOME/.config`.
- Set `ZDOTDIR` to `$HOME/.config/zsh`.
> Use `.zshenv` or `.zprofile` to set these variables. 
You need to logout and login again for these to take effect.

- Run `git submodule update --init --recursive` to initialize submodules.
- [pnpm](https://pnpm.io/installation) to install `node.js`.
- [rustup](https://www.rust-lang.org/tools/install) to install `rust` and `cargo`.
- (Mac) Install `readline` and `libyaml`. (Install these first before installing `rbenv`) 
- [rbenv](https://github.com/rbenv/rbenv) to install `ruby` and `bundler`.
- Install `go`. -- Some language servers are written in `go`.
- Install [ripgrep](https://github.com/BurntSushi/ripgrep) for `fzf` to work properly.
- Install `zsh`, [tmux](https://github.com/tmux/tmux), [kitty](https://sw.kovidgoyal.net/kitty/) or [alacritty](https://alacritty.org/).
- Install [neovim](https://neovim.io/) and [packer](https://github.com/wbthomason/packer.nvim) for managing plugins.
- Install `flutter`.
- Run `./symlink.sh` to create symlinks.

> I no longer use `i3`.

## Language Servers

See `mason` and `null-ls` configs for more details.
Use `mason` to install language servers.

## Debugging

Run `:checkhealth` in neovim to check for any errors.
