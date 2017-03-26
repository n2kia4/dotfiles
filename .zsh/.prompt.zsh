##################
##### Prompt #####
##################

# PROMPT
USER_NAME="%{$fg[red]%}[%n]%{$reset_color%}"
HOST_NAME="%{$fg[blue]%}[%m]%{$reset_color%}"
PROMPT="${USER_NAME}@${HOST_NAME}:%{$fg[magenta]%}%~
%{${reset_color}%}$ "


# RPROMPT
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git svn
zstyle ":vcs_info:*" check-for-changes true
zstyle ':vcs_info:*' stagedstr "✓"
zstyle ':vcs_info:*' unstagedstr "!"
zstyle ':vcs_info:*' formats '[%s:%b]' '(%c%u) %m'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '(%c%u) %m' '<!%a>'

zstyle ':vcs_info:git+set-message:*' hooks \
                                        git-hook-begin \
                                        git-untracked \
                                        git-push-status

function +vi-git-hook-begin() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        return 1
    fi
        return 0
}

function +vi-git-untracked() {
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if command git status --porcelain 2> /dev/null \
        | awk '{print $1}' \
        | command grep -F '??' > /dev/null 2>&1 ; then

        hook_com[unstaged]+='?'
    fi
}

function +vi-git-push-status() {
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" != "master" ]]; then
        return 0
    fi

    local ahead
    ahead=$(command git rev-list origin/master..master 2>/dev/null \
        | wc -l \
        | tr -d ' ')

    if [[ "$ahead" -gt 0 ]]; then
        hook_com[misc]+="(p${ahead})"
    fi
}

function _update_vcs_info_msg() {
    local -a msg
    local prompt

    LANG=en_US.UTF-8 vcs_info

    [[ -n "$vcs_info_msg_0_" ]] && msg+=( "%F{green}${vcs_info_msg_0_}%f" )
    [[ -n "$vcs_info_msg_1_" ]] && msg+=( "%F{yellow}${vcs_info_msg_1_}%f" )
    [[ -n "$vcs_info_msg_2_" ]] && msg+=( "%F{red}${vcs_info_msg_2_}%f" )

    prompt="${(j: :)msg}"

    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg
