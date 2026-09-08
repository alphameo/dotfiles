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

return M
