#!/bin/bash

# create config dir if not already there
mkdir -p ~/.config

# Run stow to setup dot-files and scripts
#stow --dotfiles -v -R -t ~ bash
stow --dotfiles -v -R -t ~ bin
stow --dotfiles -v -R -t ~ git
stow --dotfiles -v -R -t ~/.config neovim
stow --dotfiles -v -R -t ~ vim
stow --dotfiles -v -R -t ~ todo.txt
stow --dotfiles -v -R -t ~ emacs
stow --dotfiles -v -R -t ~ zsh

