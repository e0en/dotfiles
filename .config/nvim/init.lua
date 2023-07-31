require('plugin')
require('filetype')
require('statusline')

-- encoding
vim.opt.encoding = 'utf-8'

-- indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- line number
vim.opt.number = true

-- backups
vim.opt.updatetime = 300 -- save every 300ms

-- aesthetics
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.cmd('colorscheme yash')
require('gitsigns').setup()

-- wrapped lines continue visually indented
vim.opt.breakindent = true
