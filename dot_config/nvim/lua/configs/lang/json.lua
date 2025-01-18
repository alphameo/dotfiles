local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "vscode-json-language-server" then
  require("lspconfig").jsonls.setup {
    capabilities = lsp_utils.def_cap,

    on_new_config = function(new_config)
      new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
    end,

    settings = {
      json = {
        format = {
          enable = true,
        },
        validate = { enable = true },
      },
    },
  }
else
  vim.notify("jsonls not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
