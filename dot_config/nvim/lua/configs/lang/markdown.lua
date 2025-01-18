local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "marksman" then
  require("lspconfig").marksman.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("marksman (markdown) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
