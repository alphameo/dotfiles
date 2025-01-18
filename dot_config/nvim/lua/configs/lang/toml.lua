local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "taplo" then
  require("lspconfig").taplo.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("taplo (toml) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
