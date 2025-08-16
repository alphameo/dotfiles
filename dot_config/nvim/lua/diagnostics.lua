local icons = {
  Error = "",
  Warn = "",
  Hint = "󰌵",
  Info = "",
}

local signs = {
  text = {},
  numhl = {},
  texthl = {},
}

for type, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. type
  local severity = vim.diagnostic.severity[string.upper(type)]

  signs.text[severity] = icon
  signs.numhl[severity] = hl
  signs.texthl[severity] = hl
end

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    source = true,
    spacing = 0,
  },
  float = {
    source = true,
    border = "rounded",
  },
  update_in_insert = true,
  severity_sort = true,
  signs = signs,
}

local map = vim.keymap.set

map("n", "\\d", function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_enabled = vim.diagnostic.is_enabled { bufnr = buf_id }
  vim.diagnostic.enable(not is_enabled, { bufnr = buf_id })
  local new_buf_state = not is_enabled
  return new_buf_state and "  diagnostic" or "nodiagnostic"
end, { silent = true, desc = "Toggle Diagnostics" })

map("n", "[d", function()
  return vim.diagnostic.jump {
    count = -1,
    float = false,
  }
end, { silent = true, desc = "Previous Diagnostic" })
map("n", "]d", function()
  return vim.diagnostic.jump {
    count = 1,
    float = false,
  }
end, { silent = true, desc = "Next Diagnostic" })

map("n", "<leader>cd", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
  })
end, { silent = true, desc = "Code Open Diagnostics" })

map("n", "<leader>cD", ":Telescope diagnostics<CR>", { silent = true, desc = "Code Diagnostic List" })
map("n", "<leader>cq", ":Telescope quickfix<CR>", { silent = true, desc = "Code Quickfix" })
map("n", "<leader>cQ", ":Telescope quickfixhistory<CR>", { silent = true, desc = "Code Quickfix History" })
