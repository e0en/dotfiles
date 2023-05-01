local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'nvim-tree/nvim-web-devicons' -- a colored icon set
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp' -- Enhanced autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- Autocomplete with Nvim LSP
  use 'hrsh7th/cmp-nvim-lua' -- Autocomplete for Nvim lua
  use 'jose-elias-alvarez/null-ls.nvim' -- More language tools
  use 'ray-x/lsp_signature.nvim' -- for better python autocmplete
  use { -- Find everything
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }
  use 'nvim-tree/nvim-tree.lua' -- file tree on sidebar
  use { -- show buffer list on top
    'romgrk/barbar.nvim',
    requires = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons',
    }
  }
  use 'folke/lsp-colors.nvim' -- Better highlighting for LSP
  use 'flazz/vim-colorschemes' -- All colorschemes at once
  use 'morhetz/gruvbox' -- gruvbox colorscheme
  use 'lewis6991/gitsigns.nvim' -- Hightlight git diffs by line
  use 'glepnir/lspsaga.nvim' -- pretty LSP UIs
  use 'L3MON4D3/LuaSnip' -- auto expand using snippets
  use 'saadparwaiz1/cmp_luasnip' -- use luaSnip in cmp
  use 'rafamadriz/friendly-snippets' -- a lot of snippets
  use 'filipdutescu/renamer.nvim' -- rename like VS Code
  use {
    'nvim-treesitter/nvim-treesitter', -- parsers for a lot of languages
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- manipulate code as text objects
end)
