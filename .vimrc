set runtimepath=~/dotfiles/vim,$VIMRUNTIME

" Pathogen
execute pathogen#infect()

set nocompatible
set nu
syntax on
filetype indent plugin on
set autoindent
set ic
set lbr
"set hls
"set nohlsearch

set background=dark
colorscheme solarized
set guifont=NanumGothicCoding\ 13

" line size
set lines=80 
set textwidth=79
set colorcolumn=80

" default indentation
set sw=4
set ts=4
set et

" template files
au BufNewFile *.py 0r ~/dotfiles/vim/template/template.py
au BufNewFile *.html 0r ~/dotfiles/vim/template/template.html
