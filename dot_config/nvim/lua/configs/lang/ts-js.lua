local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "typescript-language-server" then
  require("lspconfig").marksman.setup {
    capabilities = lsp_utils.def_cap,

    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },

    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
  }
else
  vim.notify("ts_ls not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end
