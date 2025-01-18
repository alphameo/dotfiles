local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "lemminx" then
  require("lspconfig").lemminx.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("lemminx (xml) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
