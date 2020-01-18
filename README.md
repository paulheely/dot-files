# dot-files

Keep my dot-files and assorted shell scripts in one place

## Usage

Install the stow package. On Os X
    brew install stow

For each directory to link into ~ run
    stow -v -R -t ~ <DIR>

Or run the setup.sh script.

## Adding packages via git submodules example

    git submodule add https://github.com/tpope/vim-unimpaired.git vim/.vim/pack/bundle/start/vim-unimpaired

## Removing git submodule

Much harder than adding....
    Delete the relevant line from the .gitmodules file.
    Delete the relevant section from .git/config.
    Run git rm --cached path_to_submodule (no trailing slash).
    Commit the superproject.
    Delete the now untracked submodule files. 
