local M = {}

M.key_history = ""
local key_hist_lim = 10
vim.on_key(function(key)
  local mode = vim.fn.mode()
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
