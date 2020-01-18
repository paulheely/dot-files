export FIGNORE="$FIGNORE:DS_Store"
export VISUAL=nvim

# Modify the default options on common commands
alias ls="ls -F"


# Use Neovim instead of vim or vi
alias vim=nvim
alias vi=nvim

# Some convenient aliases for quickly getting to my stuff
export CURRENT_YEAR=2020
alias cda="cd ~/Documents/Docs/_Archive/${CURRENT_YEAR}"
alias cdd="cd ~/Documents/Docs/_Archive/${CURRENT_YEAR}/_Drafts"
alias vsome="vim ~/Documents/Docs/_Archive/${CURRENT_YEAR}/_Drafts/_Someday\ Maybe.md"


# Make iTerm display the current directory in the tab name.
# NB: resourcing this file will cause an error in the PROMPT_COMMAND
# So we put a guard condition in place
if [ -z $PROMPT_COMMAND_SET ] && [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
  export PROMPT_COMMAND_SET=true
fi


