# Bash #

export CLICOLOR=1
export PS1='\[\033[32m\]\W\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\] $ '

if ls --color &> /dev/null;
then
  alias ls='ls -lhF --color'
  alias lsa='ls -lahF --color'
else
  alias ls='ls -lhF'
  alias lsa='ls -lahF'
fi

# Marks #

export MARKPATH=$HOME/.marks

function jump {
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark {
  mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
  rm -i "$MARKPATH/$1"
}

function marks {
  \/bin/ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l | awk -F '/' '{print $NF}')
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

# fzf - https://github.com/junegunn/fzf #

export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD | grep --invert-match "node_modules/" ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
   grep --invert-match "node_modules/" |
      sed s/^..//) 2> /dev/null'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Go #

export GOPATH=$HOME/go
export PATH=$PATH:~/bin:/usr/local/go/bin;

# Git #

export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM="auto"

source ~/.gitprompt.sh

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

source /usr/local/etc/bash_completion.d/git-completion.bash

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Python #

export PYTHONDONTWRITEBYTECODE=1
export WORKON_HOME=$HOME/.virtualenvs

VEW=/usr/local/bin/virtualenvwrapper.sh
if [ -f $VEW ]; then
  source $VEW
fi

source ~/.bash_aliases
