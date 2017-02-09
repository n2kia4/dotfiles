alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='gls --color=auto'
alias laf='ls -AF'
alias ld='ls -d .*'
alias vi='vim'

# Web Browser
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias firefox='open -a Firefox'

# Python
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"

# Rust
alias cb='cargo build'
alias cbr='cargo build --release'
alias cr='cargo run'
alias crr='cargo run --release'

# Ruby / Ruby on Rails
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install --path vendor/bundle'
alias rg='bundle exec rails g'
alias rr='bundle exec rake routes'
alias rs='bundle exec rails s'
alias rc='bundle exec rails c'
alias rdbc='bundle exec rake db:create'
alias rdbm='bundle exec rake db:migrate'
alias rdbr='bundle exec rake db:reset'
alias rdbmr='bundle exec rake db:migrate:reset'
alias rdbs='bundle exec rake db:setup'
alias rdbd='bundle exec rake db:drop'

# Reload the shell
alias reload='exec $SHELL -l'

# PATH
alias path='echo -e ${PATH//:/\\n}'
