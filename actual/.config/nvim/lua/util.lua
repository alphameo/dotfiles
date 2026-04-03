local M = {}

M.create_hidden_buf = function()
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

M.show_info = function(text, opts)
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
