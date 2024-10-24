return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "jdtls",
          "html",
          "cssls",
          "cssmodules_ls",
          "css_variables",
          "tailwindcss",
          "ts_ls",
          "clangd",
          "pyright",
          "lemminx",
          "taplo",
          "marksman",
          "ltex",
          "texlab",
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Enable only on .java file extensions
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      local lspconfig = require "lspconfig"
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities() -- default if smth went wrong
      -- local capabilities = require("plugins.main.lspconfig").capabilities
      local on_attach = require("plugins.main.lspconfig").on_attach

      local simple_servers =
        { "html", "cssls", "css_variables", "cssmodules_ls", "tailwindcss", "clangd", "lemminx", "taplo", "marksman", "texlab", }

      -- lsps with default config
      for _, lsp in ipairs(simple_servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            diagnostics = { disable = { "missing-fields" } },
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = {
                "${3rd}/luv/library",
                unpack(vim.api.nvim_get_runtime_file("", true)),
              },
            },
            format = {
              enable = false,
            },
            hint = { enable = true },
          },
        },
      }

      lspconfig.ts_ls.setup {
        on_attach = on_attach,
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

      lspconfig.pyright.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "python" },
      }

      require("lspconfig").ltex.setup {
        filetypes = { "vimwiki", "markdown", "md", "pandoc", "vimwiki.markdown.pandoc" },
        flags = { debounce_text_changes = 300 },
        settings = {
          ltex = {
            language = "ru-RU"
            -- language = "de-DE",
          },
        },
        on_attach = on_attach,
      }
    end,
  },
}
