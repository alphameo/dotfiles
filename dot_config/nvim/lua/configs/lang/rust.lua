-- INFO: LSP
vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
        experimental = { enable = true },
      },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
})
vim.lsp.enable "rust_analyzer"

vim.g.rustaceanvim = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        inlayHints = {
          bindingModeHints = { enable = false },
          chainingHints = { enable = true },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          closureReturnTypeHints = { enable = "never" },
          lifetimeElisionHints = {
            enable = "never",
            useParameterNames = false,
          },
          maxLength = 25,
          parameterHints = { enable = true },
          reborrowHints = { enable = "never" },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
      },
    },
  },
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.rust = { "rustfmt" }

-- INFO: LINTING
-- require("lint").linters_by_ft.rust = { "bacon" }
