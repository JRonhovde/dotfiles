execute pathogen#infect()
syntax on
filetype plugin indent on

set nohlsearch
set tabstop=4
set shiftwidth=4
set expandtab
set noshowmode
set ignorecase
set smartcase
set smartindent
"set cindent
"set number
set confirm
"set display=lastline
set hidden
set lazyredraw
set scrolloff=10
" automatically adds closing parentheses
":inoremap ( ()<Esc>i
":inoremap { {}<Esc>i
":inoremap <TD>  <TD></TD><Esc>4hi
"
"


set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
let g:solarized_termtrans=1

"disable Sensible
"let g:pathogen_disabled = ['vim-sensible']
"let g:pathogen_disabled = ['airline.vim']
"let g:pathogen_disabled = ['syntastic']

"fugitive.vim settings
set diffopt+=vertical

let g:airline_powerline_fonts=1
set guifont=Anonymice_Powerline
"airline setting
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
set laststatus=2
"let g:airline_powerline_fonts = 1
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
let g:airline_section_y = ''
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 15
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
set ttimeoutlen=50

"Sytanstic settings(recommended)
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_php_checkers = ['php', 'Javascript', 'HTML', 'CSS']
"End Syntastic settings

"matchit settings
let b:match_ignorecase = 1 "matchit.vim ignores case

":ab #b /****************************************
":ab #e *****************************************/

" force .tab to use php syntax highlighting
au BufRead,BufNewFile *.tab set filetype=php

"visually select blocks of text
onoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR>
onoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR>
vnoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR><Esc>gv

function! s:IndTxtObj(inner)
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
  let i = i < 0 ? 0 : i
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction

"Highlight sql keywords(annoying)
"let php_sql_query=1

"Move up and down screen lines rather than code lines
nnoremap j gj
nnoremap k gk

"Take visually selected text and place into search and replace
vnoremap <C-r> "hy:,$s#<C-r>h##gc<left><left><left>

"GREP current word in current file
command GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

" Always use 'very magic'
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/
nnoremap :g/ :g/\v
nnoremap :g// :g//

"Centers search results
nnoremap n nzzzv
nnoremap N Nzzzv

"Syntax complete <C-X><C-O>
set omnifunc=syntaxcomplete#Complete

"search and replace error_logs, debug_logs, and alerts
command DL %s/\(\/\)\@<!debug_log/\/\/debug_log/g
command DG %s/\(\/\)\@<!debug_log/\/\/debug_log/gc
command EL %s/\(\/\)\@<!error_log/\/\/error_log/g
command EG %s/\(\/\)\@<!error_log/\/\/error_log/gc
command AL %s/\(\/\)\@<!alert/\/\/alert/gc
command EC %s/\(\/\)\@<!echo/\/\/echo/gc

"Closes php, opens JS, closes JS, opens PHP
nnoremap ;s i?><cr><SCRIPT type='text/javascript'><cr><cr></SCRIPT><cr><?<ESC>kki

"split print statement
nnoremap ;sp i");<cr>print("<ESC>k$F"h

"join print statement
nnoremap ;jp J?"<cr>v/"<cr>x

"wrap line in print statement
"nnoremap ;wp :s/\([^][^>][^$]*\)/print("\1");<cr>
"nnoremap ;wp :s/\v(%(%(\<\? *%(\=|echo) *)|%( *\?\>)|[^ ].{-})*) *$/print("\1");/g<cr>

"strip print statement from line
nnoremap ;dp :s/print("\(.*\)");/\1<cr>

"use <TAB> autocompletion in insert mode
function MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-N>"
    endif
endfunction

inoremap <Tab> <C-R>=MyTabOrComplete()<CR>

"Home key goes to first char
function! SmartHome()
  let first_nonblank = match(getline('.'), '\S') + 1
  if first_nonblank == 0
    return col('.') + 1 >= col('$') ? '0' : '^'
  endif
  if col('.') == first_nonblank
    return '0'  " if at first nonblank, go to start line
  endif
  return &wrap && wincol() > 1 ? 'g^' : '^'
endfunction
noremap <expr> <silent> <Home> SmartHome()
imap <silent> <Home> <C-O><Home>

function! Clean_bak()
    let start = line("'<")
    let stop = line("'>")
    let current = start
    let boldRow = 0
    let tableClass = 0
    let fontSize = 0
    let a = "'"

    while current <= stop 
        let class = 'none'
        let leader = 'silent! ' . current . ',' . current
        let line = getline(current)
        " only modify lines in print statments
        let startPos = match(line, '\c\v%(^[\t\s ]*)@<=print\("')
        if startPos > -1  

            "border cellpadding cellshading bgcolor=white
            "background-color:#ffffff
            let nuke = '(((background-color *: *|bgcolor\=)(#ffffff;=|white;=))|border\=0|cellpadding\=\d*|cellspacing\=\d*)'
            execute leader . 's/\v'.nuke.'*//gi'

            "give all tables the table class
            let line = getline(current)

            " newline characters
            execute leader . 's/\v\\n([" ]=\);)@=//g'

            "empty hrefs + return false
            execute leader . 's/\v(<A[^>]*)@<=href\='.a.' *'.a.' (.*onClick[^;]*;)[^r]*(return false;)/\2/gi' 

            " check if line has <table> element
            let line = getline(current)
            let tablePos = match(line, '\c\v\<table')
            if tablePos > -1  
                execute leader . 's/\v(\<table[^>]+)@<=(class\=)(.*table(-)@!)@!/class='.a.'table /gi'
                execute leader . 's/\v(\<table[^>])%(.*class\=.*$)@!/\1 class='.a.'table'.a.' /gi'
                let tableClass = 1
                if match(line, '\v\<table[^>]+se-font(-)@!') > -1
                    let fontSize = 2
                elseif match(line, '\v\<table[^>]+se-font-small') > -1
                    let fontSize = 1
                else
                    execute leader.'s/\v%(\<table[^>]+class\=)@<='.a.'=/'.a.'se-font /gi'
                    let fontSize = 2
                endif
            endif

            " if line has <\table>
            if match(line, '\v\c\</ *table *\>') > -1
                let tableClass = 0
                let fontSize = 0
            endif
           
            if fontSize != 0
                "remove font tags with size=fontSize and closing font tag
                execute leader . 's/\v\<font *%(face\=\$titlefont *|size\='.fontSize.' *){2} *\>%((.*)%(\<\/font\>)|(.*;))/\1/gi'
                "get other font size e.g. abs(2 - 3) = 1
                let otherFont = abs(fontSize - 3)
                if otherFont == 1
                    let fontClass = 'se-font-small'
                    execute leader . 's/\v(\<(td|tr)[^>]*)@<=se-font(-)@!//gi'
                elseif otherFont == 2
                    let fontClass = 'se-font'
                    execute leader . 's/\v(\<(td|tr)[^>]*)@<=se-font-small@!//gi'
                endif
                let line = getline(current)
                let fontPos = match(line, '\c\v(\<td[^>]*\>)@<=\<font([^>]+size\='.otherFont.')@=')
                let classPos = match(line, '\c\v(\<td[^>]+)@<=class\=')
                if classPos > -1 && fontPos > classPos
                    let positionStr = '\%>'.classPos.'c\%<'.fontPos.'\c'
                    execute leader . 's/'positionStr.'\v%(class\=)@<=([^a-zA-Z])=/\1'.fontClass.' /gi'
                else
                    execute leader . 's/\%<'.fontPos.'c\v(\<td)@<= =/ class='.a.fontClass.a.' /gi'
                endif
                    execute leader . 's/\v\<font *%(face\=\$titlefont *|size\='.otherFont.' *){2} *\>%((.*)%(\<\/font\>)|(.*;))/\1/gi'
            endif

            " background color  <B> tags contained within the se-bg-gray table
            " rows
            let bgColorList = '#cfcfcf|#ffcfcf|#efefef|\$titlecolor'
            let bgTags = 'tr|td|table|div'
            let line = getline(current)
            let bgList = matchlist(line, '\c\v\<@<=('.bgTags.')%([^>]+%(background-color:|bgcolor\=))('.bgColorList.')')
            if len(bgList) > 2
                let tagName = tolower(bgList[1])
                let bgcolor = bgList[2]
                if bgcolor == '#cfcfcf'
                    let class = 'se-bg-gray'
                    let boldRow = 1
                    if match(line, '\v\c<tr[^>]+se-bold') == -1
                        let class = 'se-bg-gray se-bold'
                    endif
                elseif bgcolor == '#efefef'
                    let class = 'se-bg-lgray'
                elseif bgcolor == '#ffcfcf'
                    let class = 'se-bg-pink'
                elseif bgcolor == '$titlecolor'
                    let bgcolor = '\$titlecolor'
                    let class = 'se-bg'
                endif

                execute leader.'s/\v(background-color:'.bgcolor.';=|bgcolor\='.bgcolor.')//gi'
                execute leader.'s/\vstyle\='."''".'//gi'
                execute leader.'s/\vstyle\= //gi'

                let line = getline(current)
                if match(line, '\c\v<'.tagName.'[^>]+class\=') > -1
                    execute leader . 's/\v%('.tagName.'[^>]*)@<=class\=%('.a.'([^'.a.']*)'.a.'|([^'.a.'][^ ]*))/class='.a.class.' \1'.a.' /gi'
                else
                    execute leader . 's/\v%('.tagName.')@<= / class='.a.class.a.' /i'
                endif
            endif

            let line = getline(current)
            if match(line, '\v\c\</ *tr *\>') > -1
                let boldRow = 0
            endif
            execute leader . 's/\v%(\<tr[^>]*)@<=%(%([^>]*se-bold[^'.a.'])@<!(se-bg-gray)%([^'.a.']*se-bold.*$)@!/\1 se-bold/i'

            let line = getline(current)
            if match(line, '\v\c(\<tr[^>]*)@<=se-bold') 
                let boldRow = 1
            endif
            if boldRow == 1
                execute leader . 's/\v(\<\/= *b *\>|(\<td[^>]*)@<=se-bold)//gi'
            endif
            " end bg color and bold tags

            " WIDTH ATTRIBUTES vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            " remove all width attr from table rows
            execute leader . 's/\v(\<tr[^>]*)@<=width\=[^ >]*//gi'

            "modify width attributes for these elements
            let widthTags = 'td|table|div'

            " get list containing html tag name and width amount
            let line = getline(current)
            let widthList = matchlist(line, '\c\v\<@<=('.widthTags.')%([^>]+width\='.a.'=)([\$a-zA-Z0-9\%\-\_]+)')

            if len(widthList) > 2
                let width = widthList[2]
                let widthTag = widthList[3]
                if match (line, '\v\<('.widthTag.')[^>]+style\=') > -1
                    execute leader . 's/\vwidth\='.a.'=[\$a-zA-Z0-9\%\-\_]+'.a.'=//gi'
                    execute leader . 's/\v%(\<'.widthTag.'[^>]+)@<=style\=('.a.')([^'.a.']+;='.a.')/style=\1width:'.width.';\2/gi'
                else
                    execute leader . 's/\v%(\<'.widthTag.'[^>]+)@<=width\='.a.'=[\$a-zA-Z0-9\%\-\_]+'.a.'=/style='.a.'width:'.width.';'.a.'/gi'
                endif
            endif
            " WIDTH ATTRIBUTES ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

            " ALIGN ATTRIBUTES vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            if tableClass == 1
                execute leader . 's/\v(\<td[^>]* )@<=align\=left =//gi'
            endif
            let line = getline(current)
            let alignList = matchlist(line, '\c\v%(\<td[^>]*)@<=(align\=|text-align *: *)(center|right)')
            if len(alignList) > 2
                let removeStr = alignList[1] . alignList[2]
                let removeStr = substitute(removeStr,'=','\\=',"")
                let alignClass = 'se-'.alignList[2]
                let classPos = match(line, '\c\v(\<td[^>]+)@<=class\=')
                if  classPos > -1
                    execute leader . 's/\%>'.classPos.'c\v%(class\=)@<=([^a-zA-Z])=/\1'.alignClass.' /gi'
                    execute leader . 's/\v(\<td[^>]+)@<='.removeStr.';=//i'
                else
                    execute leader . 's/\v(\<td )([^>]*)'.removeStr.';=/\1class='.a.alignClass.a.' \2/i'
                endif
            endif

            execute leader . 's/\%>'.startPos.'c\vse-left//gi'
            execute leader.'s/\vstyle\='."''".'//gi'
            execute leader.'s/\vstyle\= //gi'
            execute leader.'s/\vclass\='.a.' *'.a.'//gi'
            execute leader.'s/\vclass\= //gi'
            execute leader . 's/\%>'.startPos.'c\v  +/ /gi'
            execute leader . 's/\%>'.startPos.'c\v +('.a.')@=//gi'
        endif
        let current += 1
    endwhile
endfunction



vnoremap ;sec <esc>:SEConventions<CR>

"reload vimrc source from within vim
nnoremap <leader>sv :silent! source $MYVIMRC<CR>

" Remove a given string (with confirmation), i.e. ':Remove example' would
" remove instances of 'example' from the file.
function Remove(string)
    exe ".s/" . a:string . "//gc|1,''-&&"
endfunction
" call function
command -nargs=1 Remove call Remove(<q-args>)

"MainHeight Div Macro
let @m="/\\ctableOGlobal $MainHeight;if($MainHeight) {$height = $MainHeight - 120 .'px';print(\"<DIV style='overflow:auto;height:$height;'>\");o}/table%oif($MainHeight) print(\"</DIV>\");"

" paste 0 register 
nnoremap ;p "0p

" block comments
inoremap /* <ESC><S-o><ESC>0i/*
inoremap */ <ESC>o<ESC>0i*/

" tab line left in insert mode
inoremap << <ESC><<i

" tab line right insert mode
inoremap >> <ESC>>>i

" task search
nnoremap ;t /\$task == ['"]

" insert print statement on next line
nnoremap ;np oprint("");<ESC>hhi

" double tap i to escape
inoremap ii <ESC>

"remove whitespace
command Spaces 1,$s/\s+$//g

"Convert tabs to spaces
command Tabs 1,$s/\t/    /g

" comment out current line
nnoremap zx :,s/[A-Za-z$<\{\}\/]/\/\/&<cr>
"cnoremap zz :,s/[A-Za-z$<\{\}\/]/\/\/&<cr>
"inoremap zz :,s/[A-Za-z$<\{\}\/]/\/\/&<cr>

" remove comment on current line
nnoremap xz :,s/\/\///<cr>
"cnoremap xx :,s/\/\///<cr>
"inoremap xx :,s/\/\///<cr>

" case insensitive commands
command Q q
command W w
command Qw qw
command QW qw

" change comment colors
"hi Comment term=bold ctermfg=Green guifg=#FFFFFF


" jump to entries while typing search parameters
set incsearch 

"disable bell(ping) noises
set vb 
set t_vb=
