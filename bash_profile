# .bash_profile

set -o vi

# ssh jonron@cdh5-gateway-01
#PATH=$PATH:$HOME/bin
#export PATH

#export GREP_OPTIONS='--color=always'

#export PATH=$PATH:/usr/local/opt/go/libexec/bin

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

#source ~/.profile

#force crontab to use vim
export VISUAL=vim
export EDITOR=/usr/bin/vim

source ~/gitcomments/gitcomments.sh

export CLICOLOR=1

export GOAT=$GOPATH/src/github.com/AtScaleInc/
export AS_SUDO=$HOME/dev-vm/puppet/modules/atscale_sudoless

#alias makecentos='cd ~/docker/dev-vm/ && make OS=centos6 PORTS_POSTGRESQL=6432 ATSCALE_SKIP=true run'
#alias makecentosd='cd ~/docker/dev-vm/ && make OS=centos6 ATSCALE_FROM_MOUNT=true DAEMON=true up'
#alias makecentosd02='cd ~/docker/dev-vm/ && make OS=centos6 ATSCALE_FROM_MOUNT=true DAEMON=true up-02'
function makecentosd() { 
    cd ~/docker/dev-vm/ && make OS=centos6 ATSCALE_FROM_MOUNT=true DAEMON=true $1 
}

alias build_installer_run='cd ~/dev-vm && ./bin/build.sh -e none -o centos6 --dev && mv ~/dev-vm/atscale-*.tar.gz ~/docker/dev-vm/mount/ && cd ~/docker/dev-vm/ && makecentosd'

alias build_installer='cd ~/dev-vm && ./bin/build.sh -e none -o centos6 --dev && mv ~/dev-vm/atscale-*.tar.gz ~/docker/dev-vm/mount/'

# Trim trailing whitespaces
trim(){
    sed -i 's/ *$//g' $1
    sed -i 's/\t/    /g' $1
}

# Customize Bash Prompt
source ~/.git-prompt.sh
#export PS1='\[\e[1;32m\][\u@\h \W]\[\e[0m\]$(__git_ps1)$ ' 
#export PS1='\[[\u@\h \W]\[\e[0m\]$(__git_ps1)$ ' 
if [ $(id -u) -eq 0 ]; then
    PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
else
    if [[ $(uname -n) == "Jons-MacBook-Pro.local" ]]; then
        PS1='\[$(tput setaf 48)\][\u@\h \W]\[\e[0m\]$ '
    else
        PS1='\[$(tput setaf 196)\][\u@\h \W]\[\e[0m\]$ '
    fi
    #PS1='\[$(tput setaf 48)\][\u@\h \W]\[\e[0m\]$(__git_ps1)$ '
fi

#alias gclean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

#alias gm="git merge master || printf '\nConflict files:\n' && git status | grep 'both modified:' | sed 's/^.*both modified: *//g'"

#git completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

gsb() {
    git show $(blamecommit $1 $2) $1
}

blamecommit() {
    git blame $1 -L $2,$2 | awk '{print $1}' | sed 's/\^//'
}

grecent() {
    git show $(git log -1 --pretty=format:"%h" $1) $1
}


#source ~/docker/bin/update-docker-host.sh

# find any non-input or button elements with the 'btn' class
#grep "class=.*btn[^-].*" *.php | sed '/^.*\(<button\|<input\).*btn[^-].*$/Id'

#alias mergebase='git merge-base HEAD master'

#alias mergefiles='git status | grep "both modified:" | sed "s/^.*both modified: *//g"'
#alias gmc='vim $(git status | grep "both modified:" | sed "s/^.*both modified: *//g") +Gdiff'

alias evi='vim ~/.vimrc'
alias eb='vim ~/.bash_profile'
#alias ch='ps axu | grep httpd | wc -l'

alias rg='rg -S'

set bell-style none
bind Space:magic-space
complete -C aws_completer aws

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
