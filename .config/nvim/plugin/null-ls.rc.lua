local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

-- formatting using null-ls
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.lua_format,
    null_ls.builtins.formatting.ruff,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.diagnostics.ruff,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
