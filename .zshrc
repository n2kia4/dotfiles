# Language
export LANG='en_US.UTF-8'

# autoload
autoload -Uz colors
colors
autoload -Uz compinit
compinit
autoload -Uz add-zsh-hook
autoload -Uz history-search-end

# setopt
setopt auto_cd
setopt auto_pushd
setopt auto_list
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history

chpwd() {
  # cd -> ls
  gls -AF --color=auto

  # Automatically activate and deactivate
  if [ -d venv ]; then
    source venv/bin/activate
  elif [ "$VIRTUAL_ENV" != "" ]; then
    deactivate
  fi
}

# variable
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# prompt
PROMPT="%{${fg[yellow]}%}[%n] %~
$%{${reset_color}%} "

# alias 
source $HOME/.aliases.zsh

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# dircolors
eval $(gdircolors ~/dircolors-solarized/dircolors.ansi-universal)

if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
