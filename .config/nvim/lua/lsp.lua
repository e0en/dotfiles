-- autocomplete
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')

cmp.setup({
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local nvim_lsp = require('lspconfig')
nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  capabilities = capabilities,
}
nvim_lsp.pyright.setup {
  capabilities = capabilities,
}
nvim_lsp.clangd.setup {
  capabilities = capabilities,
}
nvim_lsp.cmake.setup {
  capabilities = capabilities,
}
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
}
nvim_lsp.jsonls.setup {
  capabilities = capabilities,
}
nvim_lsp.tsserver.setup {
  capabilities = capabilities,
}
nvim_lsp.html.setup {
  capabilities = capabilities,

}

-- formatting using null-ls

local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.shellharden,
    null_ls.builtins.formatting.shfmt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
