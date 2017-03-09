##################
##### Prompt #####
##################

zstyle ':vcs_info:*' enable git svn
zstyle ":vcs_info:*" check-for-changes true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "-"
zstyle ':vcs_info:*' formats '[%s:%b (%c%u)]'
zstyle ':vcs_info:*' actionformats '[%s:%b|%a (%c%u)]'

function _vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _vcs_info_msg

PROMPT="%{$fg[red]%}[%n]%{$reset_color%}@%{$fg[blue]%}[%m]%{$reset_color%}:%{$fg[magenta]%}%~
%{${reset_color}%}$ "

RPROMPT="%{$fg[yellow]%}%1(v|%1v|)[%D{%m/%d %H:%M}]%{$reset_color%}"
