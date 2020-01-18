#!/bin/bash
# Run stow to setup dot-files and scripts
stow -v -R -t ~ bash
stow -v -R -t ~ bin
stow -v -R -t ~ git
stow -v -R -t ~ neovim
stow -v -R -t ~ vim
