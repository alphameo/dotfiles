vim.keymap.set({ "n" }, "<leader>M", ":Mason<CR>", { silent = true, desc = "Mason" })

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  build = ":MasonUpdate",
  lazy = true,
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  config = function()
    local mason = require "mason"
    local mason_lspconfig = require "mason-lspconfig"
    local mason_dap = require "mason-nvim-dap"
    local mason_tool_installer = require "mason-tool-installer"

    mason.setup {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },

      max_concurrent_installers = 10,
    }

    mason_lspconfig.setup {
      ensure_installed = {
        "lua_ls", -- lua
        "jdtls", -- java
        "clangd", -- c, cpp
        "gopls", -- go
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
        -- "denols", -- javascript, typescript
        -- "vtsls", -- typescript
        -- "pyright", -- python
        "basedpyright", -- python static checker
        "lemminx", -- xml
        "taplo", -- toml
        "jsonls", -- json
        "yamlls", -- yaml
        "sqlls", -- sql
        "bashls", -- bash
        "intelephense", -- php
        "phpactor", -- php
        "rust_analyzer", -- rust
      },
    }

    mason_dap.setup {
      ensure_installed = {
        "javadbg", -- java-debug-adapter
        "javatest", -- java-test
        "cppdbg", -- c, cpp
        "codelldb", -- c, cpp, rust
        "python", -- python
        "js", -- javascript, typescript
        "firefox", -- javascript, typescript
        "kotlin", -- kotlin
        "delve", -- go
        "php", -- php
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "prettierd", -- ts, js, ... fmt
        "eslint_d", -- ts, js, ... lint
        "stylua", -- lua fmt
        "luacheck", -- lua lint
        "ktlint", -- kotlin fmt/lint
        "detekt", -- kotlin lint
        "clang-format", -- c, cpp fmt
        "cpplint", -- c, cpp lint
        "gersemi", -- cmake fmt
        "cmakelint", -- cmake lint
        "ruff", -- python fmt
        "black", -- python fmt
        "mypy", -- python lint
        "markdownlint-cli2", -- markdown fmt/lint
        "markdown-toc", -- markdown fmt
        "gofumpt", -- go fmt
        "goimports", -- go fmt
        "golangci-lint", -- go lint
        "php-cs-fixer", -- php fmt
        "phpcs", -- php lint
        "rustfmt", -- rust fmt
        -- "bacon-ls", -- rust
        -- "bacon", -- rust lint
        "shfmt", -- bash fmt
        -- "stylelint", -- css lint
        "htmlhint", -- html lint
        -- "jsonlint", -- json lint
        "sqlfluff", -- sql lint
        "sqlfmt", -- sql fmt
        -- "vale", -- tex lint
        "bibtex-tidy", -- tex fmt
        -- "xmlformatter", -- xml fmt
        -- "yamllint", -- yaml lint
      },
    }
    -- add binaries installed by mason.nvim to path
    local is_windows = vim.fn.has "win32" ~= 0
    local sep = is_windows and "\\" or "/"
    local delim = is_windows and ";" or ":"
    vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
  end,
}
