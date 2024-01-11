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
  "m4xshen/hardtime.nvim",       -- learn the keys!
  "nvim-tree/nvim-web-devicons", -- a colored icon set
  "neovim/nvim-lspconfig",       -- Configurations for Nvim LSP
  "hrsh7th/nvim-cmp",            -- Enhanced autocompletion
  "hrsh7th/cmp-nvim-lsp",        -- Autocomplete with Nvim LSP
  "hrsh7th/cmp-nvim-lua",        -- Autocomplete for Nvim lua
  "ray-x/lsp_signature.nvim",    -- for better python autocmplete
  {                              -- Find everything
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  "smallwat3r/vim-efficient",        -- monochrome + red accent
  "neanias/everforest-nvim",         -- greenish colorscheme
  "xero/miasma.nvim",                -- foggy woody colorscheme
  "lewis6991/gitsigns.nvim",         -- Hightlight git diffs by line
  "glepnir/lspsaga.nvim",            -- pretty LSP UIs
  "L3MON4D3/LuaSnip",                -- auto expand using snippets
  "saadparwaiz1/cmp_luasnip",        -- luaSnip in cmp
  "rafamadriz/friendly-snippets",    -- a lot of snippets
  "filipdutescu/renamer.nvim",       -- rename like VS Code
  "nvim-treesitter/nvim-treesitter", -- parsers for a lot of languages
  "nvim-treesitter/nvim-treesitter-textobjects",
  "mhartington/formatter.nvim",
  "folke/trouble.nvim", -- better diagnostics
  "github/copilot.vim",
  "luukvbaal/nnn.nvim", -- file explorer, powered by nnn
  "normen/vim-pio",     -- platformIO
})
