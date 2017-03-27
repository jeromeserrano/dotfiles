syntax on
set ruler                     " show the line number on the bar
set more                      " use more prompt
set autoread                  " watch for file changes
set number                    " line numbers
set noautowrite               " don't automagically write on :next
set lazyredraw                " don't redraw when don't have to
set showmode
set showcmd
set nocompatible              " vim, not vi
set autoindent smartindent    " auto/smart indent
set tabstop=4                 " 4 spaces
set expandtab									" convert tab to space
set shiftwidth=4
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right

set backspace=indent,eol,start
set linebreak
set cmdheight=2               " command line two lines high
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set complete=.,w,b,u,U,t,i,d  " do lots of scanning on tab completion
set ttyfast                   " we have a fast terminal
set noerrorbells              " No error bells please
set shell=bash
set fileformats=unix
set ff=unix
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set wildmode=longest:full
set wildmenu                  " menu has tab completion
let mapleader=','             " all my macros start with ,
set laststatus=2

"  searching
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

"  backup
set backup
set backupdir=~/.vim_backup
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
"set viminfo='100,f1

" mappings
" toggle list mode
nmap <Leader>tl :set list!<cr>
" toggle paste mode
nmap <Leader>pp :set paste!<cr>

:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

au BufRead,BufNewFile *.scala set filetype=scala

" color scheme
if has('gui_running')
    set background=light
else
    set background=dark
endif
"set t_Co=16
"let g:solarized_termcolors=16
colorscheme solarized

" highlight long line
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%81v.*/

" highlight space errors in java files
let java_space_errors = 1
let java_highlight_all = 1
let java_highlight_debug = 1
let java_ignore_javadoc = 1
let java_highlight_java_lang_ids = 1
let java_highlight_functions = "style"
let java_minlines = 150

augroup filetypedetect
   au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
   au BufRead,BufNewFile *.g4 set filetype=antlr4
augroup END 

" Highlight ExtraWhitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
