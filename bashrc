export CLICOLOR=1

export PYTHONDONTWRITEBYTECODE=1

# export GIT_PS1_SHOWUPSTREAM=verbose
export GIT_PS1_SHOWCOLORHINTS=true
export GIT_PS1_SHOWUPSTREAM="auto"

source ~/.gitprompt.sh

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# username ~/Current/Directory (master) $
# export PS1="\u \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1='\[\033[32m\]\W\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\] $ '

# check for whichever version of ls
if ls --color &> /dev/null;
then
  alias ls='ls -lhF --color'
  alias lsa='ls -lahF --color'
else
  alias ls='ls -lhF'
  alias lsa='ls -lahF'
fi

# marks
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

export GOPATH=$HOME/go

export PATH=$PATH:~/bin:/usr/local/go/bin;

export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD | grep --invert-match "node_modules/" ||
   find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
   grep --invert-match "node_modules/" |
      sed s/^..//) 2> /dev/null'

# git completion
source /usr/local/etc/bash_completion.d/git-completion.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

source ~/.bash_aliases
