# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

set -o vi
# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
# navigating common dirs
alias me='cd /usr/local/apache/htdocs/jc_dev/jonsdir/'
alias to='cd /usr/local/apache/htdocs/to_dev'
alias ss='cd /usr/local/apache/htdocs/jon/ss'
alias sec='cd ~/.vim/bundle/vim-se-conventions/'
alias sc='cd /usr/local/apache/htdocs/jon/sc'
alias scd='cd /usr/local/apache/htdocs/sc_dev'
alias d='cd /usr/local/apache/htdocs/dash'
alias r0='cd Reports/0/'

# Generic report card dir navigation
rc() {
    ss && cd Schools/$1/ReportCards
}

resetperl(){
    git checkout .
    perl $1
    git diff
}

# email a file
alias send='mail -s "Note From Myself" jronhovde@sycamoreleaf.com <'
alias sendbrock='mail -s "Note From Jon" brock@sycamoreleaf.com <'
alias sendglen='mail -s "SQL File List" glen@sycamoreleaf.com <'

gfiles(){
    grep -L "$2" admissions/*.php $(grep -l -s "$1" *.php) -s  > greptest.txt
    grep -L "$2" Reports/0/*.php $(grep -l -s "$1" *.php) -s >> greptest.txt
    grep -L "$2" *.php $(grep -l -s "$1" *.php) -s >> greptest.txt
    vim greptest.txt
}

lsedit(){
    vim $(find admissions/*.{php,js,inc,html,tab} admin/*.{php,js,inc,html,tab} Reports/0/*.{php,js,inc,html,tab} *.{php,js,inc,html,tab} | xargs grep $2 $1) 
}

lsview(){
    find admissions/*.{php,js,inc,html,tab} admin/*.{php,js,inc,html,tab} Reports/0/*.{php,js,inc,html,tab} *.{php,js,inc,html,tab} | xargs grep $2 $1 > greptest.txt
    vim greptest.txt
}

# better grep
# syntax: gr string method
# example: gr "functionName" open
# result: opens all files containing functionName in vim buffers
gr(){
    if [ "$2" == "open" ]; then
        # opens all matching files in vim
        vim $(find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep -l "$1")
    elif [ "$2" == "files" ]; then
        # lists all files containing matching string
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep -l "$1"
    elif [ "$2" == "count" ]; then
        # lists all matching files with # of occurences per file, skipping files with 0 matches
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep -c "$1" | sed '/:0$/d'
    elif [ "$2" == "total" ]; then
        # counts total number of occurences in all files
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs cat | grep -c "$1"
    elif [ "$2" == "viewfiles" ]; then
        # writes matching file names into a file (greptest.txt) then opens greptest.txt 
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep -l "$1" > greptest.txt
        vim greptest.txt 
    elif [ "$2" == "viewcountfiles" ]; then
        # writes matching file names into a file (greptest.txt) with # of matches then opens greptest.txt  
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep -c "$1" | sed '/:0$/d' > greptest.txt
        vim greptest.txt 
    elif [ "$2" == "and" ]; then
        # grep two separate strings !!!Does not work if either string can match to a file or dir name 
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep "$1" | grep "$3"
    elif [ "$2" == "notfiles" ]; then
        # reverse grep for filenames
        find admissions/*.php Reports/0/*.php *.php 2>/dev/null | xargs grep -L "$1"
    elif [ "$2" == "notcount" ]; then
        # reverse grep for filenames
        find admissions/*.php Reports/0/*.php *.php 2>/dev/null | xargs grep -L "$1" | wc -l
    else
        # regular grep
        find admissions/*.{php,inc,tab} Reports/0/*.{php,inc,tab} *.{php,inc,tab} 2>/dev/null | xargs grep "$1"
    fi
    return 0
}

# git show $(git blame families.php -L 100,104 | awk '{print $1}')

# Count total instances of a string
tcount(){
     cat *.* | grep -cr $1
}

# Count instances in each file
fcount(){
    grep -c $1 * | sed '/:0$/d'
}

# Trim trailing whitespaces
trim(){
    sed -i 's/ *$//g' $1
}

# first action aliases
alias ss1="ss && gckm && gpm"
alias sc1="sc && gckm && gpm"

# Customize Bash Prompt
source /usr/share/git-core/contrib/completion/git-prompt.sh
export PS1='\[\e[0;32m\][\u@\h \W]\[\e[0m\]$(__git_ps1)$ ' #works!

# dashboard
alias di="d && vi index.php"

# back one dir
alias ..="cd .."

# open last file(doesnt work)
alias last='ls -tr | tail -1'

# Monitor db access
alias m='mysql -h localhost -u topper -p sls'

# cleaner* grep
#alias gr="grep --exclude=\"DisplayBottom\""

# git commands
alias gd='git diff'
alias gc='git commit'
alias gck='git checkout'
alias ga='git add'
alias gckn='git checkout -b'
alias gckm='git checkout master'
alias gp="git checkout master && git fetch -p && git merge origin/master"
alias gpm='git pull origin master'
alias gpush='git push origin'
alias gclean='git branch --merged master | grep -v "\* master" | xargs -n 1 git branch -d'
alias gstache='git stash'
alias gpop='git stash pop'
alias gcombo='gpm && gclean'

# debug_log
alias dlogs='tail -f /usr/local/apache/htdocs/jon/debug_log | grep -v scalar'

# error_log
alias elogs='tail -f /usr/local/apache/logs/error_log | grep -v scalar'

alias vi='vim'
alias evi='vi ~/.vimrc'
alias eb='vi ~/.bash_profile'
alias myp='mysqladmin -h db -u web -pneb9604 processlist'
alias myr='/home/gellis/mysqlreport  --host db --user web --password web'
alias myra='/home/gellis/mysqlreport --all --tab  --host db --user web --password web'
alias ch='ps axu | grep httpd | wc -l'

set bell-style none
