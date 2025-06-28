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

map("n", "<leader>cD", function()
  if not vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end, { silent = true, desc = "Code Diagnostics Toggle" })

map("n", "<leader>cL", function()
  vim.opt_local.spell = not (vim.opt_local.spell:get())
  vim.notify("spell check: " .. tostring(vim.o.spell))
end, { desc = "Code SpellCheck Toggle" })
