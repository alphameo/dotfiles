-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").lua_ls.setup {
  capabilities = lsp_utils.capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      diagnostics = { disable = { "missing-fields" } },
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      format = {
        enable = false,
      },
      hint = {
        enable = true,
      },
    },
  },
}

-- INFO: FORMATTING
require("conform").formatters_by_ft.lua = { "stylua" }

-- INFO: LINTING
require("lint").linters_by_ft.lua = { "luacheck" }
