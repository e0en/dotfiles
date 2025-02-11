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
  "m4xshen/hardtime.nvim",      -- learn the keys!
  "nvim-tree/nvim-web-devicons", -- a colored icon set
  "neovim/nvim-lspconfig",      -- Configurations for Nvim LSP
  "hrsh7th/nvim-cmp",           -- Enhanced autocompletion
  "hrsh7th/cmp-nvim-lsp",       -- Autocomplete with Nvim LSP
  "hrsh7th/cmp-nvim-lua",       -- Autocomplete for Nvim lua
  "ray-x/lsp_signature.nvim",   -- for better python autocmplete
  {                             -- Find everything
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },
  "smallwat3r/vim-efficient", -- monochrome + red accent

  "cormacrelf/dark-notify",  -- auto change colorscheme based on system
  "neanias/everforest-nvim", -- greenish colorscheme
  "xero/miasma.nvim",        -- foggy woody colorscheme
  "AlexvZyl/nordic.nvim",
  "NLKNguyen/papercolor-theme",
  "lewis6991/gitsigns.nvim",        -- Hightlight git diffs by line
  "glepnir/lspsaga.nvim",           -- pretty LSP UIs
  "L3MON4D3/LuaSnip",               -- auto expand using snippets
  "saadparwaiz1/cmp_luasnip",       -- luaSnip in cmp
  "rafamadriz/friendly-snippets",   -- a lot of snippets
  "filipdutescu/renamer.nvim",      -- rename like VS Code
  "nvim-treesitter/nvim-treesitter", -- parsers for a lot of languages
  "nvim-treesitter/nvim-treesitter-textobjects",
  "mfussenegger/nvim-lint",         -- linter
  "stevearc/conform.nvim",          -- formatter
  "folke/trouble.nvim",             -- better diagnostics
  "github/copilot.vim",
  "luukvbaal/nnn.nvim",             -- file explorer, powered by nnn
  "normen/vim-pio",                 -- platformIO
  {
    "folke/which-key.nvim",         -- show key mappings
    event = "VeryLazy",
    opts = {},
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",    -- for file_selector provider mini.pick
      "hrsh7th/nvim-cmp",         -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",         -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",   -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
})
