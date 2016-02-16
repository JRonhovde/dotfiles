execute pathogen#infect()
syntax on
filetype plugin indent on
set term=xterm-256color
set termencoding=utf8
set guifont=Anonymice\ Powerline:10


" custom php syntax file
runtime syntax/php.vim

let g:CodeReviewer_reviewer='JWR'
let g:CodeReviewer_reviewFile='/usr/tmp/jronhovde-reviewer.txt'

" folding {
    "set foldlevelstart=0
    "set foldnestmax=1
    "let php_folding=1
    "let javaScript_fold=1
    "set foldmethod=indent

    "au BufReadPre * setlocal foldmethod=indent
    "au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" }


" 'set' block {
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
    " jump to entries while typing search parameters
    set incsearch 
" }

" Solarized settings {
    set t_Co=256
    let g:solarized_termcolors=256
    "let g:solarized_termtrans=1
    set background=dark
    colorscheme solarized
" }

" disable Sensible {
    "let g:pathogen_disabled = ['vim-sensible']
    "let g:pathogen_disabled = ['airline.vim']
    "let g:pathogen_disabled = ['syntastic']
" }

"fugitive.vim settings {
    set diffopt+=vertical
    "set guifont=Anonymice_Powerline
    "airline setting
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    set laststatus=2
" }


" airline.vim settings {
    let g:airline_theme='powerlineish'
    let g:airline_powerline_fonts = 1
    "let g:airline_left_sep = ''
    "let g:airline_left_alt_sep = ''
    "let g:airline_right_sep = ''
    "let g:airline_right_alt_sep = ''
    "let g:airline_symbols.branch = ''
    "let g:airline_symbols.readonly = ''
    "let g:airline_symbols.linenr = ''
    let g:airline_left_sep = '>'
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '<'
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
    "let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])

    "let g:airline_section_y = ''
    "let g:airline#extensions#default#section_truncate_width = {
                "\ 'y':200
                "\ }
    let g:airline#extensions#default#layout = [
                \ [ 'a', 'b', 'c' ],
                \ [ 'x', 'z' ]
                \ ]
    let g:airline#extensions#whitespace#mixed_indent_algo = 1
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#branch#displayed_head_limit = 20
    let g:airline#extensions#whitespace#enabled = 0
    let g:airline#extensions#tabline#enabled = 1
    set ttimeoutlen=50
" }

"Sytanstic settings(recommended) {
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 1
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_php_checkers = ['php', 'tab', 'inc']
    let g:syntastic_enable_perl_checker = 1
    let g:syntastic_perl_checkers = ['pl', 'perl']
" }

"matchit.vim settings {
    let b:match_ignorecase=1 "matchit.vim ignores case
" }

vnoremap <leader>sc <esc>:SCrud<CR>
"function! CrudGet(...)
    "let start = line("'<")
    "let stop = line("'>")
    "let current = start
    "let quotes = '"'."'"

    "let objName = matchstr(getline(current), '\v\zs\$[^,) =>]+\ze *\) *\{') 
    "let current += 1

    "while current <= stop
        "let leader = 'silent! ' . current . ',' . current
        "let line = getline(current)
        "execute leader . 's/\vmysql_result\([^'.quotes.']+['.quotes.'](.*)['.quotes.']/'.objName.'->get("\L\1"/'
        ""echo leader . 's/\vmysql_result([^'.quotes.']+'.quotes.'(.*)'.quotes.'/'.objName.'->get("\1"/'
        "let current += 1
    "endwhile
"endfunction

"visually select blocks of text {
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
" }

"Take visually selected text and place into search and replace
vnoremap <C-r> "hy:,$s#<C-r>h##gc<left><left><left>

"Search in within visual selection {
    vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
    vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
" }

" vim-se-conventions remap
vnoremap ;sec <esc>:SEConventions<CR>

" vgrep {
    function! Vgrep(pat)
        if len(a:pat) == 0
            let s:pat = expand("<cword>")
            let l:filesList = argv()
            let l:filesList = l:filesList[1:]
        else
            let l:argList = split(a:pat)
            let s:pat = l:argList[0]
            if len(l:argList) > 1
                let l:filesList = l:argList[1:]
            else
                let l:filesList = argv()
                let l:filesList = l:filesList[1:]
            endif
        endif
        let s:newfiles = join(l:filesList," ")
        execute 'silent! vimgrep /'.s:pat.'/j '.s:newfiles
        execute 'cw'
    endfunction

    command! -nargs=* Vgrep call Vgrep(<q-args>)
    "command! -nargs=1 Vgrep vimgrep /<cword>/j <q-args>
" }

"GREP current word in current file
command GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

" Always use 'very magic' {
    "nnoremap / /\v
    "vnoremap / /\v
    "cnoremap %s/ %smagic/
    "cnoremap \>s/ \>smagic/
    "nnoremap :g/ :g/\v
    "nnoremap :g// :g//
" }

"Centers search results {
    "nnoremap n nzzzv
    "nnoremap N Nzzzv
" }

"Syntax complete <C-X><C-O>
set omnifunc=syntaxcomplete#Complete

"search and replace error_logs, debug_logs, and alerts {
    command DL %s/\(\/\)\@<!debug_log/\/\/debug_log/g
    command DG %s/\(\/\)\@<!debug_log/\/\/debug_log/gc
    command EL %s/\(\/\)\@<!error_log/\/\/error_log/g
    command EG %s/\(\/\)\@<!error_log/\/\/error_log/gc
    command AL %s/\(\/\)\@<!alert/\/\/alert/gc
    command EC %s/\(\/\)\@<!echo/\/\/echo/gc
" }

"Closes php, opens JS, closes JS, opens PHP
nnoremap ;js i?><cr><SCRIPT type='text/javascript'><cr><cr></SCRIPT><cr><?<ESC>kki

" print statements {
    "join print statement
    nnoremap ;jp JF"df"

    "wrap line in print statement
    "nnoremap ;wp :s/\([^][^>][^$]*\)/print("\1");<cr>
    "nnoremap ;wp :s/\v(%(%(\<\? *%(\=|echo) *)|%( *\?\>)|[^ ].{-})*) *$/print("\1");/g<cr>

    "strip print statement from line
    nnoremap ;dp :s/\vprint\("(.*)"\);/\1/<cr>

    " insert print statement on next line
    nnoremap ;np oprint("");<ESC>hhi
    "
    "split sql/print/etc
    function SplitString()
        let col = getpos('.')
        let pos = col[2] + 1
        let line = getline('.')
        if match(line, '^\s*print(') > -1
            silent! execute ':s/\v%((^\s*).*)%<'.pos.'c/&"\);\r\1print("/'
        else
            silent! execute ':s/\v%((^\s*\$\w+).*)%<'.pos.'c/&";\r\1 .= "/'
        endif
    endfunction

    nnoremap ;ss :call SplitString()<cr>
" }

"use <TAB> autocompletion in insert mode {
function MyTabOrComplete()
    let col = col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<tab>"
    else
        return "\<C-N>"
    endif
endfunction

inoremap <Tab> <C-R>=MyTabOrComplete()<CR>
" }

"reload vimrc source from within vim
nnoremap <leader>sv :silent! source $MYVIMRC \|\| AirlineRefresh<CR>

" Remove string function {
" Remove a given string (with confirmation), i.e. ':Remove example' would
" remove instances of 'example' from the file.
function Remove(string)
    exe ".s/" . a:string . "//gc|1,''-&&"
endfunction
" call function
command -nargs=1 Remove call Remove(<q-args>)
" }

"MainHeight Div Macro {
let @m="/\\ctableOGlobal $MainHeight;if($MainHeight) {$height = $MainHeight - 120 .'px';print(\"<DIV style='overflow:auto;height:$height;'>\");o}/table%oif($MainHeight) print(\"</DIV>\");"
" }

" paste 0 register 
nnoremap ;p "0p

"Move up and down screen lines rather than code lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" tab line left in insert mode
inoremap << <ESC><<i

" tab line right insert mode
inoremap >> <ESC>>>i

" task search
nnoremap ;t /\$task == ['"]

" double tap i to escape
inoremap ii <ESC>

"remove whitespace
command Spaces 1,$s/\s+$//g

"Convert tabs to spaces
command Tabs 1,$s/\t/    /g

" case insensitive commands {
command! Q q
command! W w
command! Qw qw
command! QW qw
" }

" change comment colors
"hi Comment term=bold ctermfg=Green guifg=#FFFFFF

" force .tab to use php syntax highlighting
autocmd BufRead,BufNewFile *.tab,*.inc set filetype=php

" disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"disable bell(ping) noises {
set vb 
set t_vb=
" }
