function chpwd() {
   laf
}

function venv_auto_activate_deactivate() {
    if [ -d venv ]; then
        source venv/bin/activate
    elif [ "$VIRTUAL_ENV" != "" ]; then
        deactivate
    fi
}
add-zsh-hook chpwd venv_auto_activate_deactivate
