set runtimepath+=~/dotfiles/vim
set backupdir=~/dotfiles/vim/backups

" Vundle!!!
filetype off
set rtp+=~/dotfiles/vim/bundle/vundle/
call vundle#rc('~/dotfiles/vim/bundle')

Plugin 'gmarik/vundle'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

Plugin 'solarnz/thrift.vim'
Plugin 'derekwyatt/vim-scala'

Plugin 'Yggdroot/indentLine'
Plugin 'flazz/vim-colorschemes'

filetype plugin indent on

" ignore .gitignore files in ctrlp plugin
" taken from:
" https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" no more .netrwhist files
let g:netrw_dirhistmax = 0

" aesthetics
set t_Co=256
syntax on
set hlsearch
colorscheme base16-ateliercave

let g:indentLine_char = '|'

set macligatures
set guifont=Fira\ Code:h12

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
