require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "arduino_language_server",
    "clangd",
    "jsonls",
    "tsserver",
    "tailwindcss",
    "pyright",
    "rust_analyzer",
  },
}
