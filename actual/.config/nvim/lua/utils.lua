local M = {}

M.show_cmp = function()
  local clients = vim.lsp.get_clients { bufnr = 0 }

  if next(clients) ~= nil then
    vim.lsp.completion.get()
  else
    local key = vim.keycode "<C-x><C-n>"
    vim.api.nvim_feedkeys(key, "m", false)
  end
end

M.toggle_colorcolumn = function()
  if vim.o.colorcolumn ~= "" then
    vim.o.colorcolumn = ""
    print "nocolorcolumn"
  else
    vim.o.colorcolumn = "80"
    print("colorcolumn=" .. vim.o.colorcolumn)
  end
end

M.toggle_diagnostics = function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_enabled = vim.diagnostic.is_enabled { bufnr = buf_id }
  vim.diagnostic.enable(not is_enabled, { bufnr = buf_id })
  -- local new_buf_state = not is_enabled
  -- return new_buf_state and "  diagnostic" or "nodiagnostic"
end

M.toggle_cursorline = function()
  vim.cmd "set cursorline! cursorline?"
end

M.toggle_cursorcolumn = function()
  vim.cmd "set cursorcolumn! cursorcolumn?"
end

M.toggle_relativenumber = function()
  vim.cmd ":set relativenumber! relativenumber?"
end

M.toggle_glyphs = function()
  vim.cmd "set list! list?"
end

M.toggle_wrap = function()
  vim.cmd "setlocal wrap! wrap?"
end

M.toggle_spell = function()
  vim.cmd "setlocal spell! spell?"
end

M.toggle_expandtab = function()
  vim.cmd "setlocal expandtab! expandtab?"
end

M.show_text_popup = function(text, opts)
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
