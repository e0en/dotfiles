local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- fix warning: multiple different client offset_encodings
capabilities.offsetEncoding = { "utf-16" },

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      }
    }
  },
  capabilities = capabilities,
}
lspconfig.openscad_ls.setup {
  capabilities = capabilities,
}
lspconfig.arduino_language_server.setup {
  cmd = {
    "arduino-language-server",
    "-cli-config", "$HOME/Library/Arduino15/arduino-cli.yaml"
  },
  capabilities = capabilities,
}
lspconfig.pyright.setup {
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  capabilities = capabilities,
}
lspconfig.cmake.setup {
  capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}
lspconfig.jsonls.setup {
  capabilities = capabilities,
}
lspconfig.tsserver.setup {
  capabilities = capabilities,
}

vim.diagnostic.config({
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
