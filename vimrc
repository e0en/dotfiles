set runtimepath+=~/dotfiles/vim

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" Pathogen
execute pathogen#infect()

" python-mode                                                                   
" https://github.com/klen/python-mode                                           
let g:pymode_virtualenv=1 " Auto fix vim python paths if virtualenv enabled        
map <Leader>rgd :call RopeGotoDefinition()<CR>                                  
map <Leader>pl :PyLint<CR>                                                      
let ropevim_enable_shortcuts=1                                                  
let g:pymode_rope_goto_def_newwin="vnew"                                        
let g:pymode_rope_extended_complete=1                                           
let g:pymode_syntax=1                                                           

let g:pymode_lint_ignore = "C0110 Exported"  " ignore pep257 missing docstring warning
let g:pymode_lint_minheight = 5   " Minimal height of pylint error window          
let g:pymode_lint_maxheight = 15  " Maximal height of pylint error window          
" let g:pymode_lint_write = 0  " Disable pylint checking every save               
let g:pymode_run_key = "<leader>run"  " default key conflicts with jedi-vim        
let g:pymode_lint_mccabe_complexity = 10                                        
let g:pymode_lint_checker="pyflakes,pep8,pep257,mccabe"                         
let g:pymode_syntax_highlight_self=0  " do not highlight self                   

let g:pymode_rope_vim_completion=0  " use jedi-vim for completion               
let g:pymode_rope_guess_project=0                                               
let g:pymode_doc_key="<leader>k"  " used jedi-vim for help  


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
