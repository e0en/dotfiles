scriptencoding utf-8

" ----------------------------------
"  Dein scripts
" ----------------------------------
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

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  " lint, autocomplete
  call dein#add('w0rp/ale')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('davidhalter/jedi-vim')

  " UI
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('tpope/vim-fugitive')
  call dein#add('scrooloose/nerdtree')
  call dein#add('kien/ctrlp.vim')
  call dein#add('flazz/vim-colorschemes')

  " text editing assistants
  call dein#add('tpope/vim-surround')
  call dein#add('jiangmiao/auto-pairs')

  " thrift
  call dein#add('solarnz/thrift.vim')

  " js
  call dein#add('ternjs/tern_for_vim')
  call dein#add('pangloss/vim-javascript')

  " haskell
  call dein#add('skywind3000/asyncrun.vim')
  call dein#add('eagletmt/neco-ghc')

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

" indentation
set shiftwidth=4
set tabstop=4
set expandtab


" aesthetics
set t_Co=256
set t_ut=
set hlsearch


colorscheme monokai

if has('gui_running')
    set macligatures
    set guifont=Fira\ Code:h12
endif

" airline!
set laststatus=2
set ttimeoutlen=50
let g:airline_theme='molokai'
let g:airline_inactive_collapse=1
let g:airline_powerline_fonts=1

" UI extensions
set statusline=%{ALEGetStatusLine()}

" nerdtree!
map <C-n> :NERDTreeToggle<CR>


" ----------------------------------
"  Linter & autocomplete (via YCM)
" ----------------------------------

" ale linter settings
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

" for autocomplete
let g:jedi#force_py_version = 3
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#sources#buffer#cache_limit_size = 50000
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : '' ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
augroup omnigrp
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=jedi#completions
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'
let g:neocomplete#force_omni_input_patterns.python =
\ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:necoghc_enable_detailed_browse = 1


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


" Quick run via F5
nnoremap <F5> :call <SID>compile_and_run()<CR>

augroup asyncrungroup
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype ==? 'c'
        exec 'AsyncRun! gcc % -o %<; time ./%<'
    elseif &filetype ==? 'cpp'
        exec 'AsyncRun! g++ -std=c++11 % -o %<; time ./%<'
    elseif &filetype ==? 'java'
        exec 'AsyncRun! javac %; time java %<'
    elseif &filetype ==? 'sh'
        exec 'AsyncRun! time bash %'
    elseif &filetype ==? 'python'
        exec 'AsyncRun! time python3 %'
    elseif &filetype ==? 'haskell'
        exec 'AsyncRun! ghc % && time ./%<'
    endif
endfunction
