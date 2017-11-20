#-------------
# bash colors
#-------------

alias ls='ls --color=auto'

# PS1='\[\e[1;32m\]\u@\h \w\[\e[0m\]\[\e[1;15m\]\$\[\e[0m\] '

alias cd..="cd .."
alias gl="glances"

source ~/.nix-profile/etc/profile.d/nix.sh


# SDKMAN
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
