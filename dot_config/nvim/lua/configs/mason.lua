return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local mason = require "mason"

    local mason_lspconfig = require "mason-lspconfig"

    local mason_dap = require "mason-nvim-dap"

    local mason_tool_installer = require "mason-tool-installer"

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }

    mason_lspconfig.setup {
      ensure_installed = {
        "lua_ls",
        "jdtls",
        "clangd",
        "marksman",
        "texlab",
        "kotlin_language_server",
        "html",
        "cssls",
        "cssmodules_ls",
        "css_variables",
        "tailwindcss",
        "ts_ls",
        "pyright",
        "lemminx",
        "taplo",
      },
    }

    mason_dap.setup {
      ensure_installed = {
        "javadbg",
        "javatest",
        "cppdbg",
        "codelldb",
        "python",
        "js",
        "bash",
        "kotlin",
      },
    }
    mason_tool_installer.setup {
      ensure_installed = {
        "prettierd", -- ts/js formatter
        "eslint_d", -- ts/js linter
        "stylua", -- lua formatter
        "shfmt", -- Shell formatter
        "checkmake", -- linter for Makefiles
        "ktlint",
        "cmakelang",
        "clang-format",
        "cpplint",
        "ruff",
        "mypy",
        "black",
        "markdownlint-cli2",
      },
    }
    vim.keymap.set({ "n" }, "<leader>M", ":Mason<cr>", { silent = true, desc = "Mason" })
  end,
}
