-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "vscode-html-language-server" then
  require("lspconfig").html.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("html not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.html = { "prettierd" }

-- INFO: LINTING
require("lint").linters_by_ft.html = { "htmlhint" }
