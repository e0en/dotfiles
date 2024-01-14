require("lint").linters_by_ft = {
  c = { "clangtidy" },
  cmake = { "cmakelint" },
  cpp = { "cppcheck" },
  lua = { "luacheck" },
  python = { "ruff" },
  sh = { "shellcheck" },
  sql = { "sqlfluff" },
  toml = { "taplo" },
  zsh = { "zsh" },
}
