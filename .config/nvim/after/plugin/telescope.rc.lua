local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

function FindRootDir()
	local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		return vim.fn.getcwd()
	else
		return cwd
	end
end

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
			i = {
				["<C-n>"] = require("telescope.actions").cycle_history_next,
				["<C-p>"] = require("telescope.actions").cycle_history_prev,
			},
		},
	},
	pickers = {
		colorscheme = {
			enable_preview = true,
		},
	},
})

-- find things
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		find_command = { "rg", "--files", "--follow", "--hidden" },
		no_ignore = false,
		file_ignore_patterns = { ".git" },
		cwd = FindRootDir(),
	})
end)
vim.keymap.set("n", "<leader>fg", function()
	builtin.live_grep({
		additional_args = function(opts)
			return { "--hidden" }
		end,
		file_ignore_patterns = { ".git" },
		cwd = FindRootDir(),
	})
end)

vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>fi", builtin.lsp_implementations, {})
vim.keymap.set("n", "<leader>fc", builtin.colorscheme, {})

-- go to things
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
vim.keymap.set("n", "gt", builtin.lsp_type_definitions, {})
