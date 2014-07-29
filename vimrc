set runtimepath+=~/dotfiles/vim
set backupdir=~/dotfiles/vim/backups

set nocompatible
filetype off
filetype plugin indent on

" remove current directory from PYTHONPATH (to avoid name conflictions)
python << EOF
import os
import sys

cwd = os.getcwd()
if cwd in sys.path:
    sys.path.remove(cwd)
EOF

" Pathogen
call pathogen#infect('~/dotfiles/vim/bundle/{}')

" re-add current directory from PYTHONPATH
python << EOF
import os
import sys

sys.path.append(os.getcwd())
EOF

" python-mode                                                                   
" this line should make vim to use current virtualenv
let g:pymode_virtualenv = 1

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" no folding
let g:pymode_folding = 0

" code check
let g:pymode_lint_minheight = 5   " Minimal height of pylint error window
let g:pymode_lint_maxheight = 15  " Maximal height of pylint error window
let g:pymode_lint_mccabe_complexity = 10
let g:pymode_lint_checker="pyflakes,pep8,pep257,mccabe"
let g:pymode_lint_write = 1

" pep8-compatible indentation
let g:pymode_indent = 1

" resolve conflicts with jedi-vim
let g:pymode_rope = 0
let g:pymode_run_key = "<leader>run"  " default key conflicts with jedi-vim
let g:pymode_doc_key = "<leader>k"  " used jedi-vim for help

set background=dark
colorscheme solarized
if has('gui_running')
    set guifont=NanumGothicCoding\ 13
endif

" line size
set lines=80 
set textwidth=79
set colorcolumn=80

" default indentation
set shiftwidth=4
set tabstop=4
set expandtab

" line numbering
set nu

" template files
au BufNewFile *.py 0r ~/dotfiles/vim/template/template.py
au BufNewFile *.html 0r ~/dotfiles/vim/template/template.html
