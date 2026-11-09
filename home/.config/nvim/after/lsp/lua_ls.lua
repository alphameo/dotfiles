return {
  settings = {
    Lua = {
      diagnostics = { disable = { "missing-fields" } },
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- '${3rd}/luv/library',
          -- '${3rd}/busted/library'
          -- vim.api.nvim_get_runtime_file('', true),
        },
      },
      format = { enable = false },
      hint = { enable = true },
    },
  },
}
