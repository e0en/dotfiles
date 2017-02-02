scriptencoding utf-8

" dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/e0en/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/e0en/.vim/bundle')
  call dein#begin('/Users/e0en/.vim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/e0en/.vim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " lint, autocomplete
  call dein#add('w0rp/ale')
  call dein#add('Valloric/YouCompleteMe')

  " UI
  call dein#add('tpope/vim-fugitive')
  call dein#add('scrooloose/nerdtree')
  call dein#add('kien/ctrlp.vim')
  call dein#add('flazz/vim-colorschemes')

  call dein#add('tpope/vim-surround')
  call dein#add('jiangmiao/auto-pairs')

  " thrift
  call dein#add('solarnz/thrift.vim')

  " js
  call dein#add('ternjs/tern_for_vim')
  call dein#add('pangloss/vim-javascript')

  " haskell
  call dein#add('lukerandall/haskellmode-vim')
  call dein#add('neovimhaskell/haskell-vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" no more .netrwhist files
let g:netrw_dirhistmax = 0


" ignore .gitignore files in ctrlplugin
" taken from:
" https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" aesthetics
set t_Co=256
set hlsearch
colorscheme base16-ateliercave

if has('gui_running')
    set macligatures
    set guifont=Fira\ Code:h12
endif

" line size
set textwidth=79
set colorcolumn=80

" default indentation
set shiftwidth=4
set tabstop=4
set expandtab

" line numbering
set number

" UI extensions
set statusline=%{ALEGetStatusLine()}

" template files
augroup newfilegroup
    au BufNewFile __init__.py 0r ~/dotfiles/vim/template/__init__.py
    au BufNewFile *.py 0r ~/dotfiles/vim/template/template.py
    au BufNewFile *.html 0r ~/dotfiles/vim/template/template.html
augroup END

set backupskip=/tmp/*,/private/tmp/*

" ale linter settings
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

" nerdtree!
map <C-n> :NERDTreeToggle<CR>

" for haskellmode-vim
let g:haddock_browser = 'open'
let g:haddock_browser_callformat = '%s %s'

" for autocomplete
let g:ycm_python_binary_path = 'python3'


" tmux
set t_ut=

" crontab!
if $VIM_CRONTAB ==? 'true'
    set nobackup
    set nowritebackup
endif

augroup crontabgroup
    au BufEnter /private/tmp/crontab.* setl backupcopy=yes
augroup end


