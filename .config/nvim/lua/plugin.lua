local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp' -- Enhanced autocompletion
  use 'hrsh7th/cmp-nvim-lsp' -- Autocomplete with Nvim LSP
  use 'hrsh7th/cmp-nvim-lua' -- Autocomplete for Nvim lua
  use 'jose-elias-alvarez/null-ls.nvim' -- More language tools
  use { -- Find everything
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }
  use 'folke/lsp-colors.nvim' -- Better highlighting for LSP
  use 'flazz/vim-colorschemes' -- All colorschemes at once
end)
