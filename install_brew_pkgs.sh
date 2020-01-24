pkgs_to_install=(ack
                 coreutils
                 ctags
                 fzf
                 neovim
                 node
                 pandoc
                 prettier
                 pyenv
                 pyenv-virtualenv
                 pyenv-virtualenvwrapper
                 python
                 ripgrep
                 stow
                 todo-txt
                 tree
                 vim)

for pkg in ${pkgs_to_install[@]};do
        echo $pkg
done




