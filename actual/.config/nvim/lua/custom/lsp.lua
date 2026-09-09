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

M.refresh_diagnostics = function ()
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client:supports_method("workspace/diagnostic") then
      vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
    else
      vim.diagnostic.reset(nil, 0)
      vim.cmd("checktime")
    end
  end
  vim.notify("Diagnostics refreshed", vim.log.levels.INFO)
end
return M
