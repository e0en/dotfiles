local status, telescope = pcall(require, "telescope")
if (not status) then return end
local builtin = require("telescope.builtin")
local actions = require('telescope.actions')

function FindRootDir()
  local cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  else
    return cwd
  end
end


telescope.setup {
  defaults = {
    mappings = {
      n = {
        ['q'] = actions.close
      },
      i = {
        ["<C-n>"] = require('telescope.actions').cycle_history_next,
        ["<C-p>"] = require('telescope.actions').cycle_history_prev,
      },
    }
  },
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}

-- find things
vim.keymap.set('n', '<leader>ff', function()
  builtin.find_files({
    find_command = { 'rg', '--files', '--follow', '--hidden' },
    no_ignore = false,
    file_ignore_patterns = { '.git' },
    cwd = FindRootDir(),
  })
end)
vim.keymap.set('n', '<leader>fg', function()
  builtin.live_grep({
    file_ignore_patterns = { '.git' },
    cwd = FindRootDir(),
  })
end)

vim.keymap.set('n', '<leader>fb', function()
  builtin.buffers()
end)

vim.keymap.set('n', '<leader>fh', function()
  builtin.help_tags()
end)

vim.keymap.set('n', '<leader>fd', function()
  builtin.diagnostics()
end)

vim.keymap.set('n', '<leader>fs', function()
  builtin.lsp_dynamic_workspace_symbols()
end)

vim.keymap.set('n', '<leader>fr', function()
  builtin.lsp_references()
end)

vim.keymap.set('n', '<leader>fi', function()
  builtin.lsp_implementations()
end)

-- go to things
vim.keymap.set('n', 'gd', function()
  builtin.lsp_definitions()
end)

vim.keymap.set('n', 'gi', function()
  builtin.lsp_implementations()
end)

vim.keymap.set('n', 'gt', function()
  builtin.lsp_type_definitions()
end)
