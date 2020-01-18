export FIGNORE="$FIGNORE:DS_Store"

export CURRENT_YEAR=2020

alias cda="cd ~/Documents/Docs/_Archive/${CURRENT_YEAR}"
alias cdd="cd ~/Documents/Docs/_Archive/${CURRENT_YEAR}/_Drafts"
alias vsome="vim ~/Documents/Docs/_Archive/${CURRENT_YEAR}/_Drafts/_Someday\ Maybe.md"


if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi


