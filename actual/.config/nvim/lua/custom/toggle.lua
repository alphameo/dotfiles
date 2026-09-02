local M = {}

M.colorcolumn = function()
  if vim.o.colorcolumn ~= "" then
    vim.o.colorcolumn = ""
    print "nocolorcolumn"
  else
    vim.o.colorcolumn = "80"
    print("colorcolumn=" .. vim.o.colorcolumn)
  end
end

M.diagnostics = function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_enabled = vim.diagnostic.is_enabled { bufnr = buf_id }
  vim.diagnostic.enable(not is_enabled, { bufnr = buf_id })
  -- local new_buf_state = not is_enabled
  -- return new_buf_state and "  diagnostic" or "nodiagnostic"
end

M.cursorline = function()
  vim.cmd "set cursorline! cursorline?"
end

M.cursorcolumn = function()
  vim.cmd "set cursorcolumn! cursorcolumn?"
end

M.relativenumber = function()
  vim.cmd ":set relativenumber! relativenumber?"
end

M.glyphs = function()
  vim.cmd "set list! list?"
end

M.wrap = function()
  vim.cmd "setlocal wrap! wrap?"
end

M.spell = function()
  vim.cmd "setlocal spell! spell?"
end

M.expandtab = function()
  vim.cmd "setlocal expandtab! expandtab?"
end
return M
