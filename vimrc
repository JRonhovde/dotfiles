execute pathogen#infect()
syntax on
filetype plugin indent on
runtime syntax/php.vim

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
" jump to entries while typing search parameters
set incsearch 

" Solarized settings {
    set t_Co=256
    set background=dark
    let g:solarized_termcolors=256
    colorscheme solarized
    let g:solarized_termtrans=1
" }

" disable Sensible {
    "let g:pathogen_disabled = ['vim-sensible']
    "let g:pathogen_disabled = ['airline.vim']
    "let g:pathogen_disabled = ['syntastic']
" }

"fugitive.vim settings {
    set diffopt+=vertical

    let g:airline_powerline_fonts=1
    set guifont=Anonymice_Powerline
    "airline setting
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    set laststatus=2
" }


" airline.vim settings {
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
" }

"Sytanstic settings(recommended) {
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_php_checkers = ['php', 'Javascript', 'HTML', 'CSS']
" }

"matchit.vim settings {
    let b:match_ignorecase=1 "matchit.vim ignores case
" }

":ab #b /****************************************
":ab #e *****************************************/


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

"Highlight sql keywords(annoying)
"let php_sql_query=1


"Take visually selected text and place into search and replace
vnoremap <C-r> "hy:,$s#<C-r>h##gc<left><left><left>

"Search in within visual selection
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" vim-se-conventions remap
vnoremap ;sec <esc>:SEConventions<CR>

"GREP current word in current file
command GREP :execute 'vimgrep '.expand('<cword>').' '.expand('%') | :copen | :cc

" Always use 'very magic'
"nnoremap / /\v
"vnoremap / /\v
"cnoremap %s/ %smagic/
"cnoremap \>s/ \>smagic/
"nnoremap :g/ :g/\v
"nnoremap :g// :g//

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

"Move up and down screen lines rather than code lines
nnoremap j gj
nnoremap k gk

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
"nnoremap zx :,s/[A-Za-z$<\{\}\/]/\/\/&<cr>
"cnoremap zz :,s/[A-Za-z$<\{\}\/]/\/\/&<cr>
"inoremap zz :,s/[A-Za-z$<\{\}\/]/\/\/&<cr>

" remove comment on current line
"nnoremap xz :,s/\/\///<cr>
"cnoremap xx :,s/\/\///<cr>
"inoremap xx :,s/\/\///<cr>

" case insensitive commands
command Q q
command W w
command Qw qw
command QW qw

" change comment colors
"hi Comment term=bold ctermfg=Green guifg=#FFFFFF

" force .tab to use php syntax highlighting
au BufRead,BufNewFile *.tab set filetype=php


"disable bell(ping) noises
set vb 
set t_vb=
