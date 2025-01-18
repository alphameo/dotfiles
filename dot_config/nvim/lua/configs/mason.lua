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
        "lua_ls", -- lua
        "jdtls", -- java
        "clangd", -- c, cpp
        "neocmake", -- cmake
        "marksman", -- markdown
        "texlab", -- LaTeX
        "kotlin_language_server", -- kotlin
        "html", -- html
        "cssls", -- css
        "cssmodules_ls", -- css
        "css_variables", -- css
        "tailwindcss", -- tailwind
        "ts_ls", -- javascript, typescript
        "pyright", -- python
        "lemminx", -- xml
        "taplo", -- toml
        "jsonls",
        "yamlls",
        "sqlls",
        "bashls",
      },
    }

    mason_dap.setup {
      ensure_installed = {
        "javadbg", -- java-debug-adapter
        "javatest", -- java-test
        "cppdbg", -- c, cpp
        "codelldb", -- c, cpp, rust
        "python", -- python
        "js",
        "kotlin", -- kotlin
      },
    }
    mason_tool_installer.setup {
      ensure_installed = {
        "prettierd", -- ts, js, ... fmt
        "eslint_d", -- ts, js, ... lint
        "stylua", -- lua fmt
        "ktlint", -- kotlin fmt/lint
        "clang-format", -- c, cpp fmt
        -- "cmakelang", -- cmake fmt
        "cmakelint", -- cmake lint
        "cpplint", -- c, cpp lint
        "ruff", -- python fmt
        "black", -- python fmt
        "mypy", -- python lint
        "markdownlint-cli2", -- markdown fmt/lint
        "markdown-toc", -- markdown fmt
      },
    }
    vim.keymap.set({ "n" }, "<leader>M", ":Mason<cr>", { silent = true, desc = "Mason" })
  end,
}
