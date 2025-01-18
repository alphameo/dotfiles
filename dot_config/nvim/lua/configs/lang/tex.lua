local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "texlab" then
  require("lspconfig").texlab.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("texlab (tex) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
