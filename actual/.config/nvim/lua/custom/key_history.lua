local M = {}

M.last = ""
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

  M.last = key

  if #M.last > key_hist_lim then
    M.last = M.last:sub(-key_hist_lim)
  end
end)

return M
