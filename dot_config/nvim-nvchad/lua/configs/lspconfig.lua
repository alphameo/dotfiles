-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "lua_ls",
  "html",
  "cssls",
  "ts_ls",
  "eslint",
  "java_language_server",
  "clangd",
  "pyright",
  "sqlls",
  "postgres_lsp",
  "jsonls",
  "marksman",
  "texlab",
  "bashls"
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
