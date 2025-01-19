-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "bash-language-server" then
  require("lspconfig").bashls.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("bashls (sh) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.bash = { "shfmt" }

-- INFO: LINTING
require("lint").linters_by_ft.bash = { "shellcheck" }
