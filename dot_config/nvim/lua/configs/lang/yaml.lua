-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "yaml-language-server" then
  local new_capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  }

  require("lspconfig").yamlls.setup {
    capabilities = vim.tbl_deep_extend("force", lsp_utils.capabilities, new_capabilities),

    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        keyOrdering = false,
        format = {
          enable = true,
        },
        validate = true,
        schemaStore = {
          -- Must disable built-in schemaStore support to use
          -- schemas from SchemaStore.nvim plugin
          enable = false,
          -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
          url = "",
        },
      },
    },
  }
else
  vim.notify("yamlls (yaml) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.yaml = { "prettierd" }

-- INFO: LINTING
require("lint").linters_by_ft.yaml = { "yamllint" }
