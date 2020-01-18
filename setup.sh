#!/bin/bash

# pull in any submodules
git submodule init
git submodule update

# Run stow to setup dot-files and scripts
stow -v -R -t ~ bash
stow -v -R -t ~ bin
stow -v -R -t ~ git
stow -v -R -t ~ neovim
stow -v -R -t ~ vim
