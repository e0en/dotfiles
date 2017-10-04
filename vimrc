scriptencoding utf-8


" ----------------------------------
" Vundle Scripts 
" ----------------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

filetype off                  " required

" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

" UI
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'

" thrift
Plugin 'solarnz/thrift.vim'

" wakatime!
Plugin 'wakatime/vim-wakatime'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"filetype plugin on          " use to ignore plugin indent changes
syntax enable


" ----------------------------------
"  General settings
" ----------------------------------

" temporary file settings
let g:netrw_dirhistmax = 0
set backupskip=/tmp/*,/private/tmp/*

" line size
set textwidth=79
set colorcolumn=80
set number
set relativenumber

" indentation
set shiftwidth=4
set tabstop=4
set expandtab

" aesthetics
set t_Co=256
set t_ut=
set hlsearch
set cursorline
colorscheme CandyPaper

" utilities
set wildmenu
set lazyredraw
set showmatch

if has('gui_running')
    set macligatures
    set guifont=Fira\ Code:h12
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
