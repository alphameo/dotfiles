local M = {}

M.new_hidden_win_state = function(opts, win_config)
  local buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = "hide"
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

M.create_split_buffer = function(opts)
  opts = opts or {}

  local win_config = {
    vertical = false,
    split = "below",
    height = 15,
    style = "minimal",
  }

  return M.new_hidden_win_state(opts, win_config)
end

M.create_floating_window = function(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = "minimal",
    border = "rounded",
  }

  return M.new_hidden_win_state(opts, win_config)
end

M.open_win = function(text, title)
  local text_lines = vim.split(text, "\n")
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, text_lines)

  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = "wipe"
  if title then
    vim.bo[buf].filetype = "text"
  end

  local width = 60
  local height = #text_lines
  local config = {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
  }

  local win = vim.api.nvim_open_win(buf, true, config)

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].cursorline = false
  vim.wo[win].signcolumn = "no"

  return win, buf
end

M.key_history = ""
local key_hist_lim = 10
vim.on_key(function(key)
  -- local mode = vim.fn.mode()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" or mode == "R" then
    return
  end

  key = vim.fn.keytrans(key)

  -- ignore mouse
  if key:match "<Mouse" then
    return
  end

  -- key_history = key_history .. key
  M.key_history = key

  if #M.key_history > key_hist_lim then
    M.key_history = M.key_history:sub(-key_hist_lim)
  end
end)

return M
