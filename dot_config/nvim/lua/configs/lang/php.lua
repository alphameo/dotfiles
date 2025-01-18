local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "intelephense" then
  require("lspconfig").intelephense.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("intelephense (php) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if lsp_utils.executable "phpactor" then
  require("lspconfig").phpactor.setup {
    capabilities = lsp_utils.def_cap,
  }
else
  vim.notify("phpactor (php) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- DAP
local dap = require "dap"
local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { path .. "/extension/out/phpDebug.js" },
}
