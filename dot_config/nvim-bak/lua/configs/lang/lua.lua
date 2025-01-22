-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "lua-language-server" then
  require("lspconfig").lua_ls.setup {
    capabilities = lsp_utils.def_cap,
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
        hint = { enable = true },
      },
    },
  }
else
  vim.notify("lua_ls not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: FORMATTING
require("conform").formatters_by_ft.lua = { "stylua" }

-- INFO: LINTING
require("lint").linters_by_ft.lua = { "luacheck" }
