local M = {}

M.show = function(text, opts)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local lines = vim.split(text, "\n")
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)

  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].modified = false
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = opts.ft or "info"

  local winid = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    width = vim.o.columns - 6,
    height = vim.o.lines - 6,
    col = 2,
    row = 2,
    style = "minimal",
    border = "rounded",
  })

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = bufnr, nowait = true })
  vim.keymap.set("n", "<C-c>", "<cmd>close<cr>", { buffer = bufnr })

  vim.api.nvim_create_autocmd("BufLeave", {
    desc = "Close info window when leaving buffer",
    buffer = bufnr,
    once = true,
    nested = true,
    callback = function()
      if vim.api.nvim_win_is_valid(winid) then
        vim.api.nvim_win_close(winid, true)
      end
    end,
  })
end

return M
