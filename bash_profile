# .bash_profile

set -o vi
# User specific environment and startup programs

source /usr/local/bin/bash_profile_sycamore
source /home/jronhovde/perl/inc_functions.sh
#PATH=$PATH:$HOME/bin
#export PATH

for f in ~/scripts/*.sh; do source $f; done
for b in ~/.bash_profile_*; do source $b; done

# navigating common dirs
alias sec='cd ~/.vim/bundle/vim-se-conventions/'
#alias df='cd ~/dotfiles'

export GREP_OPTIONS='--color=always'

source ~/gittrello/gittrello.sh

#force crontab to use vim
export VISUAL=vim
export EDITOR=vim


resetperl(){
    git checkout .
    perl $1
    git diff
}

# Trim trailing whitespaces
trim(){
    sed -i 's/ *$//g' $1
    sed -i 's/\t/    /g' $1
}

# Customize Bash Prompt
#source /usr/share/git-core/contrib/completion/git-prompt.sh
export PS1='\[\e[1;32m\][\u@\h \W]\[\e[0m\]$(__git_ps1)$ ' #overwrites /usr/local/bin/bash_profile_sycamore

alias gclean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'

alias gm="git merge master || printf '\nConflict files:\n' && git status | grep 'both modified:' | sed 's/^.*both modified: *//g'"

gsb() {
    git show $(blamecommit $1 $2) $1
}

blamecommit() {
    git blame $1 -L $2,$2 | awk '{print $1}' | sed 's/\^//'
}

grecent() {
    git show $(git log -1 --pretty=format:"%h" $1) $1
}

# find any non-input or button elements with the 'btn' class
#grep "class=.*btn[^-].*" *.php | sed '/^.*\(<button\|<input\).*btn[^-].*$/Id'

alias mergebase='git merge-base HEAD master'

alias mergefiles='git status | grep "both modified:" | sed "s/^.*both modified: *//g"'
alias gmc='vim $(git status | grep "both modified:" | sed "s/^.*both modified: *//g") +Gdiff'

alias evi='vi ~/.vimrc'
alias eb='vi ~/.bash_profile*'
alias ch='ps axu | grep httpd | wc -l'

set bell-style none
bind Space:magic-space
