# Load
for file in ~/.zsh/*.zsh; do
    source $file
done

# direnv
eval "$(direnv hook zsh)"

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
