require("nnn").setup({
  picker = {
    cmd = "tmux new-session nnn -a -H -Pp",
    style = { border = "rounded" },
  },
  replace_netrw = "picker",
  offset = true,
})

vim.keymap.set("n", "<C-n>", "<cmd>NnnPicker<CR>", { noremap = true, silent = true })
