if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if has('win32')
    let $MYPLUGDIRECTORY = "~/vimfiles/plugged"
else
    let $MYPLUGDIRECTORY = "~/.vim/plugged"
endif

call plug#begin($MYPLUGDIRECTORY)

Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'kien/ctrlp.vim'
if !has('win32')
    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'junegunn/fzf'
endif
Plug 'joshdick/onedark.vim'
Plug 'edmorrish/vim-svelte'

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

colorscheme onedark

if has('gui_running')
    if has('macunix')
        set macligatures
        set guifont=Hack:h10
    elseif has('win32')
        set guifont=D2Coding_Ligature:h10
    endif
    set lines=40
    set columns=120
    colorscheme onedark
endif

" ----------------------------------
"  Programming language-specifics
" ----------------------------------


" Language client settings
autocmd BufRead *.js setlocal filetype=javascript
autocmd BufRead *.py setlocal filetype=python

filetype plugin on
let g:lsp_settings = {
\  'pyls': {'cmd': ['pyls']}
\}
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '~~'}

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
