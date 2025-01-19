-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "neocmakelsp" then
  require("lspconfig").neocmake.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("neocmake (cmake) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.cmake = { "gersemi" }

-- INFO: LINTING
require("lint").linters_by_ft.cmake = { "cmakelint" }
