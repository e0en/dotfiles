local M = {}
local preview_win

function M.peek(capture)
  if preview_win and vim.api.nvim_win_is_valid(preview_win) then
    vim.api.nvim_set_current_win(preview_win)
    return
  end

  vim.lsp.buf.definition({
    on_list = function(options)
      local item = options.items[1]
      if not item then
        return
      end
      local bufnr = item.bufnr or vim.fn.bufadd(item.filename)
      vim.fn.bufload(bufnr)
      local ok, range = pcall(
        require("nvim-treesitter-textobjects.shared").textobject_at_point,
        capture,
        "textobjects",
        bufnr,
        { item.lnum, item.col - 1 }
      )
      local start_row, end_row = item.lnum - 1, item.end_lnum or item.lnum
      if ok and range then
        start_row = range[1]
        end_row = range[4] + (range[5] > 0 and 1 or 0)
      end
      local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_row, false)
      local preview_buf
      preview_buf, preview_win = vim.lsp.util.open_floating_preview(lines, vim.bo[bufnr].filetype, {
        border = "none",
        focus_id = "treesitter-definition",
      })
      local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
      if lang and vim.treesitter.language.add(lang) then
        vim.treesitter.start(preview_buf, lang)
      end
    end,
  })
end

return M
