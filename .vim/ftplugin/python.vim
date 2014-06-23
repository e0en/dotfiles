setlocal ts=4
setlocal sts=4
setlocal sw=4
setlocal textwidth=79
setlocal smarttab
setlocal expandtab
"setlocal shiftround    " round indent to multiple of 'shiftwidth'
"setlocal autoindent    " align the new line indent with the previous line

autocmd BufWritePost *.py call Flake8()
