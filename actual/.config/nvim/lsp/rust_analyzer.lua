return {
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
}
