return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    config = function()
      local lspconfig = require "lspconfig"

      local capabilities = require("configs.lspconfig").capabilities

      local simple_servers = {
        "kotlin_language_server",
        "html",
        "cssls",
        "css_variables",
        "cssmodules_ls",
        "tailwindcss",
        "lemminx", -- xml
        "taplo", -- toml
      }

      -- lsps with default config
      for _, lsp in ipairs(simple_servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }
      end


      lspconfig.ts_ls.setup {
        capabilities = capabilities,
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

    end,
  },
}
