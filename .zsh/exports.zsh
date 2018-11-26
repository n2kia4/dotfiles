# Language
export LANG='en_US.UTF-8'

# Editor
export EDITOR='vim'

# Path
#-------------------------------------------------------------------------------
# local
export PATH=/usr/local/bin:$PATH

# dotfiles
export DOTFILES_PATH="$HOME/dotfiles"
export PATH=$DOTFILES_PATH/bin:$PATH

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
