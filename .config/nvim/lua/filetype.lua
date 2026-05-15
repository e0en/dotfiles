vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "python",
  command = "setlocal textwidth=79 colorcolumn=80 shiftwidth=4 tabstop=4",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "javascript", "html", "css", "*.svelte" },
  command = "setlocal textwidth=120 colorcolumn=121",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function(args)
    -- Workaround for Neovim 0.12 markdown Tree-sitter crash.
    -- Remove this once the upstream markdown parser/query issue is fixed.
    pcall(vim.treesitter.stop, args.buf)
  end,
})
