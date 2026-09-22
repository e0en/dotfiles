-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  -- learn the keys!
  "m4xshen/hardtime.nvim",

  -- a colored icon set
  "nvim-tree/nvim-web-devicons",

  -- Configurations for Nvim LSP
  "neovim/nvim-lspconfig",

  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP-based completion
      "hrsh7th/cmp-nvim-lua", -- autocomplete for neovim scripts
      "hrsh7th/cmp-nvim-lsp-signature-help", -- lean signature popup
    },
  },

  { -- Find everything
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },

  -- analysis
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Requires Neovim >= 0.12.
    lazy = false,
    build = ":TSUpdate", -- Requires tree-sitter-cli >= 0.26.1 and a C compiler.
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    init = function()
      vim.g.no_plugin_maps = true
    end,
  },
  "folke/trouble.nvim",

  -- linter / formatter
  "mfussenegger/nvim-lint",
  "stevearc/conform.nvim",

  -- git
  "lewis6991/gitsigns.nvim",

  -- rust
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  -- platformIO
  "normen/vim-pio",

  -- decorations
  "cormacrelf/dark-notify",
  "neanias/everforest-nvim",
})
