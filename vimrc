" Basic Settings
syntax on
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins
set shell=bash

" Display Settings
set number                    " line numbers
set ruler                     " show the line number on the bar
set laststatus=2
set lazyredraw                " don't redraw when don't have to

" Indentation and Tabs
set autoindent smartindent    " auto/smart indent
set tabstop=4                 " 4 spaces
set expandtab                 " convert tab to space
set shiftwidth=4

" Search Settings
set incsearch                 " incremental search
set ignorecase                " search ignoring case
set smartcase                 " case-sensitive when uppercase present
set hlsearch                  " highlight the search
set showmatch                 " show matching bracket
set diffopt=filler,iwhite     " ignore all whitespace and sync

" File Handling
set autoread                  " watch for file changes
set noautowrite               " don't automagically write on :next
set fileformats=unix
set backup
silent! call mkdir(expand('~/.vim_backup'), 'p')
set backupdir=~/.vim_backup

" Scrolling
set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right
set linebreak

" Editor Behavior
set undolevels=1000           " 1000 undos
set updatecount=100           " switch every 100 chars
set noerrorbells              " No error bells please
set ttimeoutlen=10            " faster escape
set clipboard=unnamed         " yank/paste with system clipboard

" Persistent Undo
if has('persistent_undo')
    silent! call mkdir(expand('~/.vim_undo'), 'p')
    set undodir=~/.vim_undo
    set undofile
endif

" Command Line
set wildmode=longest:full
set wildignore+=*.o,*.obj,*.pyc,*.class,*.swp,*~,*.DS_Store

" File Type Settings
au BufRead,BufNewFile *.scala set filetype=scala

augroup filetypedetect
   au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
   au BufRead,BufNewFile *.g4 set filetype=antlr4
augroup END

" Color and Highlighting
if has('termguicolors')
    set termguicolors
endif
" Disable vim's async OSC 11 background query; it overrides &background after
" vimrc runs.
" FIXME: herdr returns a light color for OSC 11 regardless of the actual theme
" (https://github.com/ogulcancelik/herdr/issues/714). Remove once that's fixed.
set t_RB=
" Match WezTerm's Everforest — warm, green-tinted, low-blue, easy on the eyes.
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1

" Follow the macOS light/dark appearance. The `vim` shell wrapper passes it in
" as g:macos_appearance (set before this file, so the first frame is correct);
" without the wrapper, query it here.
if exists('g:macos_appearance')
    let &background = (g:macos_appearance ==# 'dark') ? 'dark' : 'light'
else
    let &background = system('/usr/bin/defaults read -g AppleInterfaceStyle 2>/dev/null') =~# 'Dark' ? 'dark' : 'light'
endif
silent! colorscheme everforest

" Re-check on focus so toggling macOS mode while vim is open is picked up.
function! s:SyncBackground() abort
    let l:want = system('/usr/bin/defaults read -g AppleInterfaceStyle 2>/dev/null') =~# 'Dark' ? 'dark' : 'light'
    if &background !=# l:want
        let &background = l:want
        silent! colorscheme everforest
    endif
endfunction

augroup EverforestAutoSwitch
    autocmd!
    autocmd FocusGained * call s:SyncBackground()
augroup END

" Whitespace Highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Viminfo Settings
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo

" Bracketed Paste Mode
if &term =~ "xterm" || &term =~ "screen" || &term =~ "kitty" || &term =~ "tmux" || &term =~ "iterm"
    let &t_BE = "\<Esc>[?2004h"
    let &t_BD = "\<Esc>[?2004l"
    let &t_PS = "\<Esc>[200~"
    let &t_PE = "\<Esc>[201~"
endif
