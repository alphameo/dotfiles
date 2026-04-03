local M = {}

local function open_new_hidden_win(opts, win_config)
  local bufid
  if vim.api.nvim_buf_is_valid(opts.buf) then
    bufid = opts.buf
  else
    bufid = vim.api.nvim_create_buf(false, true)
    vim.bo[bufid].buflisted = false
    vim.bo[bufid].swapfile = false
    vim.bo[bufid].bufhidden = "hide"
  end

  local winid = vim.api.nvim_open_win(bufid, true, win_config)

  return { buf = bufid, win = winid }
end

local split_win_conf = {
  vertical = false,
  split = "below",
  height = 15,
  style = "minimal",
}

local float_win_conf = {
  relative = "editor",
  style = "minimal",
  border = "rounded",
}

M.create_split_buffer = function(opts)
  opts = opts or {}

  return open_new_hidden_win(opts, split_win_conf)
end

M.create_floating_window = function(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local win_conf = float_win_conf
  win_conf.width = width
  win_conf.height = height
  win_conf.row = (vim.o.lines - height) / 2
  win_conf.col = (vim.o.columns - width) / 2

  return open_new_hidden_win(opts, win_conf)
end

M.show_info = function(text, opts)
  local lines = vim.split(text, "\n")
  local bufnr = vim.api.nvim_create_buf(false, true)
  local winid = vim.api.nvim_open_win(bufnr, true, {
    relative = "editor",
    border = "rounded",
    width = vim.o.columns - 6,
    height = vim.o.lines - 6,
    col = 2,
    row = 2,
    style = "minimal",
  })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)

  vim.bo[bufnr].modifiable = false
  vim.bo[bufnr].modified = false
  vim.bo[bufnr].bufhidden = "wipe"
  vim.bo[bufnr].filetype = opts.ft or "info"

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

-- Key history

M.key_history = ""
local key_hist_lim = 20
vim.on_key(function(key)
  -- local mode = vim.fn.mode()
  local mode = vim.api.nvim_get_mode().mode
  if mode == "i" or mode == "R" then
    return
  end

  key = vim.fn.keytrans(key)

  -- ignore mouse
  if key:match "Mouse" or key:match "Wheel" or key:match "Drag" or key:match "Release" then
    return
  end

  -- key_history = key_history .. key
  M.key_history = key

  if #M.key_history > key_hist_lim then
    M.key_history = M.key_history:sub(-key_hist_lim)
  end
end)

return M
