local status, saga = pcall(require, "lspsaga")
if (not status) then return end

-- pretty UI using lspsaga
saga.init_lsp_saga()

local opt = { silent = true, noremap = true }

-- preview things
vim.keymap.set('n', 'gp', '<cmd>Lspsaga preview_definition<CR>', opt)
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opt)

-- code manipulation
vim.keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
