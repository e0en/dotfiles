set runtimepath+=~/dotfiles/vim
set backupdir=~/dotfiles/vim/backups

set nocompatible


" Vundle!!!
filetype off
set rtp+=~/dotfiles/vim/bundle/vundle/
call vundle#rc('~/dotfiles/vim/bundle')

Plugin 'gmarik/vundle'
Plugin 'davidhalter/jedi-vim'
Plugin 'klen/python-mode'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ervandew/supertab'
Plugin 'derekwyatt/vim-scala'
Plugin 'junegunn/seoul256.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'solarnz/thrift.vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'airblade/vim-gitgutter'

filetype plugin indent on

let g:indent_guides_enable_on_vim_startup = 0

" syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1

" ignore .gitignore files in ctrlp plugin
" taken from:
" https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" no more .netrwhist files
let g:netrw_dirhistmax = 0

if has("python")

" remove current directory from PYTHONPATH (to avoid name conflictions)
python << EOF
import os
import sys

cwd = os.getcwd()
if cwd in sys.path:
    sys.path.remove(cwd)
EOF

" re-add current directory from PYTHONPATH
python << EOF
import os
import sys

sys.path.append(os.getcwd())
EOF

endif

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

" let us add some colors
syntax on
set background=dark
set hlsearch
colorscheme seoul256

if has('gui_running')
    set guifont=NanumGothicCoding\ 13
    set lines=80
endif

" line size
set textwidth=79
set colorcolumn=80

" default indentation
set shiftwidth=4
set tabstop=4
set expandtab

" line numbering
set nu

" template files
au BufNewFile __init__.py 0r ~/dotfiles/vim/template/__init__.py
au BufNewFile *.py 0r ~/dotfiles/vim/template/template.py
au BufNewFile *.html 0r ~/dotfiles/vim/template/template.html

" gui-specific settings
if has('gui_running')
    set guifont=NanumGothicCoding\ 13
    set lines=80
endif

" tmux
set t_ut=

" crontab!
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
set backupskip=/tmp/*,/private/tmp/*


" nerdtree!
map <C-n> :NERDTreeToggle<CR>
