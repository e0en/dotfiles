vim.lsp.enable("lua_ls")
vim.lsp.enable("openscad_ls")
vim.lsp.enable("ty")
vim.lsp.enable("ruff")
vim.lsp.enable("clangd")
vim.lsp.enable("cmake")
vim.lsp.enable("jsonls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("wgsl_analyzer")

vim.diagnostic.config({
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format()
  end,
})
