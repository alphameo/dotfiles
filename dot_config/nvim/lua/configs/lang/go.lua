-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "gopls" then
  local util = require "lspconfig.util"
  require("lspconfig").gopls.setup {
    capabilities = lsp_utils.capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        completeUnimported = true,
        usePlaceholders = true,
        staticcheck = true,
      },
    },
  }
else
  vim.notify("gopls (go) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: DAP
require("dap-go").setup()

-- INFO: FORMATTING
require("conform").formatters_by_ft.go = { "goimports", "gofumpt" }

-- INFO: LINTING
require("lint").linters_by_ft.go = { "golangcilint" }
