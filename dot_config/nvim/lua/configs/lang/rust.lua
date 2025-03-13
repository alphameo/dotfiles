-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").rust_analyzer.setup {
  cmd = { "rust-analyzer" },
  capabilities = lsp_utils.capabilities,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
      cargo = {
        allFeatures = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

--   require("lspconfig").bacon_ls.setup {
--     capabilities = lsp_utils.capabilities(),
--     -- enabled = diagnostics == "bacon-ls",
--   }

-- INFO: FORMATTING
require("conform").formatters_by_ft.rust = { "rustfmt" }

-- INFO: LINTING
-- require("lint").linters_by_ft.rust = { "bacon" }
