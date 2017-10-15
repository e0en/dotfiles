scriptencoding utf-8

set runtimepath+=$HOME/dotfiles/vim/

" ----------------------------------
"  General settings
" ----------------------------------

set nocompatible               " Be iMproved
filetype plugin indent on    " required
syntax enable

" temporary file settings
let g:netrw_dirhistmax = 0
set backupskip=/tmp/*,/private/tmp/*

" line size
set textwidth=79
set colorcolumn=80
set number

" indentation
set shiftwidth=4
set tabstop=4
set expandtab

" aesthetics
set t_Co=256
set t_ut=
set hlsearch
set cursorline

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
