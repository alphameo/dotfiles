local lsp_utils = require "configs.lspconfig"

if not lsp_utils.executable "marksman" then
  vim.notify("marksman not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- DAP
local dap = require "dap"

dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}
