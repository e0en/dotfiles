call plug#begin()

Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/indentpython.vim'
Plug 'kien/ctrlp.vim'
if !has('win32')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tjdevries/coc-zsh'
    Plug 'junegunn/fzf'
endif
Plug 'joshdick/onedark.vim'
Plug 'edmorrish/vim-svelte'

call plug#end()

scriptencoding utf-8

" ----------------------------------
"  General settings
" ----------------------------------

set encoding=utf-8
set fileformat=unix

syntax enable
filetype plugin indent on

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
set softtabstop=4
set expandtab
set smarttab
set autoindent

" remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

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

if has('gui_running')
    if has('macunix')
        set macligatures
        set guifont=Hack:h10
    elseif has('win32')
        set guifont=D2Coding_Ligature:h10
    endif
    set lines=40
    set columns=120
endif

" ----------------------------------
"  Programming language-specifics
" ----------------------------------


" Language client settings
" taken from https://github.com/neoclide/coc.nvim
"
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

autocmd BufRead *.js setlocal filetype=javascript
autocmd BufRead *.py setlocal filetype=python

" template files
augroup newfilegroup
    autocmd BufNewFile __init__.py 0r ~/dotfiles/vim/template/__init__.py
    autocmd BufNewFile *.py 0r ~/dotfiles/vim/template/template.py
    autocmd BufNewFile *.html 0r ~/dotfiles/vim/template/template.html
augroup END

" Python!
autocmd FileType python
    \ setlocal textwidth=79 colorcolumn=80
autocmd BufRead,BufNewFile *.py,*,pyw match BadWhitespace /\s\+$/
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" C++
autocmd FileType cpp
    \ setlocal textwidth=120 colorcolumn=121

" javascript
autocmd FileType javascript,html,css
    \ setlocal textwidth=120 colorcolumn=121 shiftwidth=2 softtabstop=2
autocmd FileType javascript,html,css match BadWhitespace /\s\+$/
autocmd FileType javascript,html,css match BadWhitespace /^\t\+/

" svelte
autocmd BufRead,BufNewFile *.svelte
    \ setlocal textwidth=120 colorcolumn=121 shiftwidth=2 softtabstop=2
autocmd BufRead,BufNewFile *.svelte match BadWhitespace /\s\+$/
autocmd BufRead,BufNewFile *.svelte match BadWhitespace /^\t\+/


" ----------------------------------
"  Other settings
" ----------------------------------

" crontab!
if $VIM_CRONTAB ==? 'true'
    set nobackup
    set nowritebackup
endif

augroup crontabgroup
    autocmd BufEnter /private/tmp/crontab.* setl backupcopy=yes
augroup end

" ignore .gitignore files in ctrlplugin
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
