#!/bin/bash

# pull in any submodules
git submodule init
git submodule update

# Run stow to setup dot-files and scripts
stow --dotfiles -v -R -t ~ bash
stow --dotfiles -v -R -t ~ bin
stow --dotfiles -v -R -t ~ git
stow --dotfiles -v -R -t ~ neovim
stow --dotfiles -v -R -t ~ vim

