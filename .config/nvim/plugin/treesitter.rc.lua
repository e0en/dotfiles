local treesitter = require("nvim-treesitter")

-- Prefer updated parsers over any parsers left in the old plugin directory.
treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })
treesitter.install({
  "bash",
  "c",
  "cpp",
  "css",
  "gitignore",
  "html",
  "javascript",
  "json",
  "json5",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "rust",
  "sql",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or not require("nvim-treesitter.parsers")[lang] then
      return
    end
    treesitter.install({ lang }):await(vim.schedule_wrap(function(err, installed)
      if err or not installed or not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end
      if vim.bo[args.buf].filetype == args.match then
        vim.treesitter.start(args.buf, lang)
      end
    end))
  end,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "<c-v>",
    },
    include_surrounding_whitespace = true,
  },
  move = { set_jumps = true },
})

for key, capture in pairs({
  af = "@function.outer",
  ["if"] = "@function.inner",
  ac = "@class.outer",
  ic = "@class.inner",
}) do
  vim.keymap.set({ "x", "o" }, key, function()
    require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
  end)
end

for key, method in pairs({ ["<leader>a"] = "swap_next", ["<leader>A"] = "swap_previous" }) do
  vim.keymap.set("n", key, function()
    require("nvim-treesitter-textobjects.swap")[method]("@parameter.inner")
  end)
end

for method, mappings in pairs({
  goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
  goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
  goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
  goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
}) do
  for key, capture in pairs(mappings) do
    vim.keymap.set({ "n", "x", "o" }, key, function()
      require("nvim-treesitter-textobjects.move")[method](capture, "textobjects")
    end)
  end
end

-- The main branch removed lsp_interop; retain definition previews with the LSP API.
for key, capture in pairs({ ["<leader>df"] = "@function.outer", ["<leader>dF"] = "@class.outer" }) do
  vim.keymap.set({ "n", "x" }, key, function()
    require("treesitter-peek").peek(capture)
  end)
end
