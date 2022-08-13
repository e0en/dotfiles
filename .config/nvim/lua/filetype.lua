vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'python',
  command = 'setlocal textwidth=79 colorcolumn=80 shiftwidth=4 tabstop=4',
});


vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'cpp',
  command = 'setlocal textwidth=120 colorcolumn=121 shiftwidth=4 tabstop=4',
});


vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'javascript', 'html', 'css', '*.svelte' },
  command = 'setlocal textwidth=120 colorcolumn=121',
});
