-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if not lsp_utils.executable "rust-analyzer" then
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
  vim.notify("rust_analyzer (rust) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- if lsp_utils.executable "bacon-ls" then
--   require("lspconfig").bacon_ls.setup {
--     capabilities = lsp_utils.capabilities(),
--     -- enabled = diagnostics == "bacon-ls",
--   }
-- else
--   vim.notify("bacon_ls (rust) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
-- end

-- INFO: FORMATTING
require("conform").formatters_by_ft.rust = { "rustfmt" }

-- INFO: LINTING
-- require("lint").linters_by_ft.rust = { "bacon" }
