return {
  -- {
  --   "williamboman/mason.nvim",
  --   lazy = false,
  --   config = function()
  --     require("mason").setup()
  --     vim.keymap.set({ "n" }, "<leader>M", ":Mason<cr>", { silent = true, desc = "Mason" })
  --   end,
  -- },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   config = function()
  --     require("mason-lspconfig").setup {
  --       ensure_installed = {
  --         "lua_ls",
  --         "jdtls",
  --         "clangd",
  --         "marksman",
  --         "texlab",
  --         "kotlin_language_server",
  --         "html",
  --         "cssls",
  --         "cssmodules_ls",
  --         "css_variables",
  --         "tailwindcss",
  --         "ts_ls",
  --         "pyright",
  --         "lemminx",
  --         "taplo",
  --       },
  --     }
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    config = function()
      local lspconfig = require "lspconfig"

      local capabilities = require("configs.lspconfig").capabilities
      local on_attach = require("configs.lspconfig").on_attach

      local simple_servers = {
        -- "kotlin_language_server",
        "html",
        "cssls",
        "css_variables",
        "cssmodules_ls",
        "tailwindcss",
        "lemminx",
        "taplo",
      }

      -- lsps with default config
      for _, lsp in ipairs(simple_servers) do
        lspconfig[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
      end

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
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
    end,
  },
}
