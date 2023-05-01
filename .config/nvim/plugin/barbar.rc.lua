require("barbar").setup{}

vim.keymap.set('n', '[b', ":BufferPrev<CR>", { silent = true })
vim.keymap.set('n', 'b]', ":BufferNext<CR>", { silent = true })
