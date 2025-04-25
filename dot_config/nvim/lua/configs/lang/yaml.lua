-- INFO: LSP
vim.lsp.config("yamlls", {
  capabilities = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
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
})
vim.lsp.enable "yamlls"

-- INFO: FORMATTING
-- require("conform").formatters_by_ft.yaml = { "prettierd" }

-- INFO: LINTING
-- require("lint").linters_by_ft.yaml = { "yamllint" }
