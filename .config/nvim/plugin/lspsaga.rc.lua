local status, saga = pcall(require, "lspsaga")
if (not status) then return end

-- pretty UI using lspsaga
saga.init_lsp_saga()

local opt = { silent = true, noremap = true }
local action = require('lspsaga.action')
-- scroll up/down hover doc or scroll in definition preview
vim.keymap.set('n', '<C-f>', function()
    action.smart_scroll_with_saga(1)
end, opt)
vim.keymap.set('n', '<C-b>', function()
    action.smart_scroll_with_saga(-1)
end, opt)

-- preview things
vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opt)
vim.keymap.set('n', 'gp', '<cmd>Lspsaga preview_definition<CR>', opt)
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opt)

-- code manipulation
local codeaction = require('lspsaga.codeaction')
vim.keymap.set('n', '<leader>ca', codeaction.code_action, opt)
vim.keymap.set('v', '<leader>ca', function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-U>', true, false, true))
    codeaction.range_code_action()
end, { silent = true })
