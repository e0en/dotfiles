require("conform").setup({
  formatters_by_ft = {
    c = { "clang_format" },
    cmake = { "cmake_format" },
    cpp = { "clang_format" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    lua = { "stylua" },
    markdown = { "prettierd" },
    python = { "ruff_format" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    sql = { "sqlfluff" },
    toml = { "taplo" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    yaml = { "yamlfmt" },

    ["*"] = {
      "trim_whitespace",
      "trim_newlines",
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})
