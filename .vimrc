if has('win32')
    let $MYPLUGDIRECTORY = "~/vimfiles/plugged"
else
    let $MYPLUGDIRECTORY = "~/.vim/plugged"
endif

call plug#begin($MYPLUGDIRECTORY)

Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'kien/ctrlp.vim'
if !has('win32')
    Plug 'Valloric/YouCompleteMe'
endif
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jelera/vim-javascript-syntax'
Plug 'joshdick/onedark.vim'

call plug#end()

scriptencoding utf-8

" ----------------------------------
"  General settings
" ----------------------------------

set nocompatible               " Be iMproved

set encoding=utf-8
set fileformat=unix

syntax enable
filetype plugin indent on    " required

" temporary file settings
let g:netrw_dirhistmax = 0
set backupskip=/tmp/*,/private/tmp/*

" line size
set textwidth=79
set colorcolumn=80
highlight ColorColumn ctermbg=9
set number

" indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
set autoindent

" aesthetics
set t_Co=256
set t_ut=
set hlsearch
set cursorline
hi CursorLine term=bold cterm=bold
highlight BadWhitespace ctermbg=red guibg=red
colorscheme onedark

" utilities
set wildmenu
set lazyredraw
set showmatch

if has('gui_running')
    if has('macunix')
        set macligatures
        set guifont=Hack:h10
    elseif has('win32')
        set guifont=D2Coding_Ligature:h10
    endif
    set lines=40
    set columns=120
    colorscheme molokai
endif

" ----------------------------------
"  Programming language-specifics
" ----------------------------------

" template files
augroup newfilegroup
    au BufNewFile __init__.py 0r ~/dotfiles/vim/template/__init__.py
    au BufNewFile *.py 0r ~/dotfiles/vim/template/template.py
    au BufNewFile *.html 0r ~/dotfiles/vim/template/template.html
augroup END

" Python!
au BufRead,BufNewFile *.py,*.pyw set textwidth=79
au BufRead,BufNewFile *.py,*.pyw set colorcolumn=80
au BufRead,BufNewFile *.py,*,pyw match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
let python_highlight_all=1

" C++
au BufRead,BufNewFile *.cpp,*.c,*.h,*.hpp set textwidth=120
au BufRead,BufNewFile *.cpp,*.c,*.h,*.hpp set colorcolumn=121

" javascript
au BufRead,BufNewFile *.js,*.mjs set textwidth=120
au BufRead,BufNewFile *.js,*.mjs set colorcolumn=121
au BufRead,BufNewFile *.js,*.mjs set shiftwidth=2
au BufRead,BufNewFile *.js,*.mjs set tabstop=2
au BufRead,BufNewFile *.js,*.mjs set softtabstop=2
au BufRead,BufNewFile *.js,*.mjs match BadWhitespace /\s\+$/
au BufRead,BufNewFile *.js,*.mjs match BadWhitespace /^\t\+/



" ----------------------------------
"  Other settings
" ----------------------------------

" crontab!
if $VIM_CRONTAB ==? 'true'
    set nobackup
    set nowritebackup
endif

augroup crontabgroup
    au BufEnter /private/tmp/crontab.* setl backupcopy=yes
augroup end

" ignore .gitignore files in ctrlplugin
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
