return {
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      completion = { callable = { snippets = "none" } },
      diagnostics = {
        enable = true,
        experimental = { enable = true },
      },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
}
