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

local virt_text = {
  current_line = true,
  source = true,
  spacing = 0,
  hl_mode = "replace",
  virt_text_pos = "eol",
}

local virt_lines = {
  current_line = true,
}

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    current_line = false,
    source = true,
    spacing = 0,
    hl_mode = "replace",
    virt_text_pos = "eol",
  },
  virtual_lines = virt_lines,
  float = {
    source = true,
    border = "rounded",
  },
  signs = signs,
  update_in_insert = false,
  severity_sort = true,
}

local is_virt_line = true

M.toggle_virtual = function()
  is_virt_line = not is_virt_line

  if is_virt_line then
    virt_text.current_line = false
    vim.diagnostic.config {
      virtual_text = virt_text,
      virtual_lines = virt_lines,
    }
    vim.notify("Diagnostics: Virtual Lines", vim.log.levels.INFO)
  else
    virt_text.current_line = nil
    vim.diagnostic.config {
      virtual_text = virt_text,
      virtual_lines = false,
    }
    vim.notify("Diagnostics: Virtual Text", vim.log.levels.WARN)
  end
end

return M
