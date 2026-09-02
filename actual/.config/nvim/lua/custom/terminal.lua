local M = {}

local create_hidden_buf = function()
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.bo[bufnr].buflisted = false
  vim.bo[bufnr].swapfile = false
  vim.bo[bufnr].bufhidden = "hide"

  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = bufnr, nowait = true })
  vim.keymap.set("n", "<C-c>", "<cmd>close<cr>", { buffer = bufnr })
  return bufnr
end

local function create_hidden_win(bufnr, win_config)
  local winid = vim.api.nvim_open_win(bufnr, true, win_config)

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

  return winid
end

M.create_hidden_split = function(bufnr)
  local win_conf = {
    vertical = false,
    split = "below",
    height = math.floor(vim.o.lines * 0.3),
    style = "minimal",
  }

  return create_hidden_win(bufnr, win_conf)
end

M.create_hidden_float = function(bufnr)
  local win_conf = {
    relative = "editor",
    width = vim.o.columns - 6,
    height = vim.o.lines - 6,
    row = 2,
    col = 2,
    style = "minimal",
    border = "rounded",
  }

  return create_hidden_win(bufnr, win_conf)
end

local term_win_state = {
  buf = -1,
  win = -1,
}

M.toggle_terminal = function(create_win_func)
  if not vim.api.nvim_buf_is_valid(term_win_state.buf) then
    term_win_state.buf = create_hidden_buf()
  end
  if not vim.api.nvim_win_is_valid(term_win_state.win) then
    term_win_state.win = create_win_func(term_win_state.buf)
    if vim.bo[term_win_state.buf].buftype ~= "terminal" then
      vim.api.nvim_call_function("termopen", { vim.o.shell })
    end
    vim.cmd "startinsert"
  else
    vim.api.nvim_win_hide(term_win_state.win)
    vim.cmd "stopinsert"
  end
end

-- Split Terminal

M.toggle_split_terminal = function()
  M.toggle_terminal(M.create_hidden_split)
end

M.toggle_float_terminal = function()
  M.toggle_terminal(M.create_hidden_float)
end

return M
