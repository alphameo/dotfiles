local M = {}
M.icons = {
  Error = " ",
  Warn = " ",
  Hint = "󰌵 ",
  Info = " ",
}

local signs = {
  text = {},
  numhl = {},
  texthl = {},
}

for type, icon in pairs(M.icons) do
  local hl = "DiagnosticSign" .. type
  local severity = vim.diagnostic.severity[string.upper(type)]

  signs.text[severity] = icon
  signs.numhl[severity] = hl
  signs.texthl[severity] = hl
end

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    current_line = false,
    source = true,
    spacing = 0,
    hl_mode = "replace",
    virt_text_pos = "eol",
  },
  virtual_lines = {
    current_line = true,
  },
  float = {
    source = true,
    border = "rounded",
  },
  signs = signs,
  update_in_insert = false,
  severity_sort = true,
}

return M
