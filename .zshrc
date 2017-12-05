# Language
export LANG='en_US.UTF-8'

# autoload
autoload -Uz colors
colors
autoload -Uz compinit
compinit
autoload -Uz add-zsh-hook
autoload -Uz history-search-end
autoload -Uz vcs_info

# setopt
setopt auto_cd
setopt auto_pushd
setopt auto_list
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history
setopt prompt_subst

# variable
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

# Alias
source $HOME/.zsh/.aliases.zsh

# Prompt
source $HOME/.zsh/.prompt.zsh

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Rust
source $HOME/.cargo/env

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


# Tmux
if [ -z "$TMUX" ]; then
    if tmux has-session &>/dev/null && tmux list-sessions | grep -qE '.*]$'; then
        tmux list-sessions | perl -pe 's/(^.*?):/\033[31m$1:\033[m/'
        printf "\x1b[37mtmux: attach? (y/N/num)\x1b[0m "
        read
        if [[ $REPLY =~ ^[Yy]$ || $REPLY == '' ]]; then
            if tmux attach-session; then
                echo "$(tmux -V) attached session"
                return 0
            fi
        elif tmux list-sessions | grep -q "^$REPLY:"; then
            if tmux attach -t "$REPLY"; then
                echo "$(tmux -V) attached session"
                return 0
            fi
        fi
    else
        tmux ls
        printf "\x1b[37mtmux: create new session? (y/N)\x1b[0m "
        read
        if [[ $REPLY =~ ^[Yy]$ || $REPLY == '' ]]; then
            tmux new-session \; source-file ~/.tmux/new-session && \
            echo "$(tmux -V) created new session"
        else
            clear
        fi
    fi
fi


# cd -> ls
_cd_ls() {
    gls -AF --color=auto
}
add-zsh-hook chpwd _cd_ls


# Automatically activate and deactivate
_auto_activate_deactivate() {
    if [ -d venv ]; then
        source venv/bin/activate
    elif [ "$VIRTUAL_ENV" != "" ]; then
        deactivate
    fi
}
add-zsh-hook chpwd _auto_activate_deactivate
