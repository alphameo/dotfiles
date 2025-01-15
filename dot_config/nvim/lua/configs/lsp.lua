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
          "kotlin_language_server",
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

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
          },
        },
      }

      local on_attach = function()
        local map = vim.keymap.set

        map({ "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, { desc = "Show Doc Hover" })
        map({ "n", "i", "v" }, "<C-S-k>", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })

        map("n", "<leader>gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition" })
        map("n", "gd", function()
          require("telescope.builtin").lsp_definitions { reuse_win = true }
        end, { desc = "Goto Definition" })

        map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })

        map("n", "<leader>gI", require("telescope.builtin").lsp_implementations, { desc = "Goto Implementations" })
        map("n", "gI", function()
          require("telescope.builtin").lsp_implementations { reuse_win = true }
        end, { desc = "Goto Implementations" })

        map("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "Goto References" })
        map("n", "gr", function()
          require("telescope.builtin").lsp_references { reuse_win = true }
        end, { desc = "Goto References" })

        map("n", "<leader>gt", require("telescope.builtin").lsp_type_definitions, { desc = "Goto Type defenition" })
        map("n", "gt", function()
          require("telescope.builtin").lsp_type_definitions { reuse_win = true }
        end, { desc = "Goto Type defenition" })

        map("n", "<leader>gb", "<C-o>", { desc = "Go Back" })
        map("n", "gb", "<C-o>", { desc = "Go Back" })

        map("n", "<leader>csd", require("telescope.builtin").lsp_document_symbols, { desc = "Code Symbols Document" })
        map(
          "n",
          "<leader>csw",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          { desc = "Code Symbols Workspace" }
        )

        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

        map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code Rename" })
        map("n", "<F2>", vim.lsp.buf.rename, { desc = "Code Rename" })

        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { 0 })
          map("n", "<leader>ah", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
          end, { desc = "Toggle Inlay Hints" })
        end
      end

      local simple_servers = {
        -- "kotlin_language_server",
        "html",
        "cssls",
        "css_variables",
        "cssmodules_ls",
        "tailwindcss",
        "clangd",
        "lemminx",
        "taplo",
        "marksman",
        -- "texlab",
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
