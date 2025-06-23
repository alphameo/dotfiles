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
