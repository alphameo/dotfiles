local M = {}

M.set = function(opts)
  local width = tonumber(opts.args)
  vim.bo.expandtab = true
  vim.bo.tabstop = width
  vim.bo.softtabstop = width
  vim.bo.shiftwidth = width

  print("local_indent=" .. width)
end

return M
