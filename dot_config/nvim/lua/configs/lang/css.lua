-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "vscode-css-language-server" then
  require("lspconfig").cssls.setup {
    capabilities = lsp_utils.capabilities(),
  }
else
  vim.notify("cssls (css) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if lsp_utils.executable "css-variables-language-server" then
  require("lspconfig").css_variables.setup {
    capabilities = lsp_utils.capabilities(),
  }
else
  vim.notify("css_variables (css) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if lsp_utils.executable "cssmodules-language-server" then
  require("lspconfig").cssmodules_ls.setup {
    capabilities = lsp_utils.capabilities(),
  }
else
  vim.notify("cssmodules_ls (css) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.css = { "prettierd" }

-- INFO: LINTING
-- ISSUE:
-- require("lint").linters_by_ft.css = { "stylelint" }
