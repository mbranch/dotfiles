alias git=hub
alias github="hub browse"
alias j=jump
alias json="python -m json.tool"
alias la="ls -la"
alias ll="ls -lF"
alias be="bundle exec"
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

# Maple #

alias d=majordomo
alias v=vagabond
alias logs="v ssh app -c \"sudo tail -f /var/log/syslog | ccze -A\""
alias errlogs="v ssh app -c \"sudo tail -f /var/log/supervisor/*stderr* | ccze -A\""

applogs() {
  v ssh app -c "sudo tail -f /var/log/syslog | grep --line-buffered \"app $1\" | ccze -A"
}

# Deliveroo #

alias z=zazu
