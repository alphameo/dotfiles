-- INFO: LSP
vim.lsp.enable "intelephense"
vim.lsp.enable "phpactor"

-- INFO: DAP
local dap = require "dap"
local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { path .. "/extension/out/phpDebug.js" },
}
