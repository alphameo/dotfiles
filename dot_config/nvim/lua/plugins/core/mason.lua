vim.keymap.set({ "n" }, "<leader>M", ":Mason<CR>", { silent = true, desc = "Mason" })

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    lazy = true,
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup {
        ui = {
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
        max_concurrent_installers = 10,
      }
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    lazy = true,
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateUpdate",
      "MasonToolsClean",
    },
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          -- LSPs
          "lua_ls", -- lua
          "jdtls", -- java
          "clangd", -- c, cpp
          "gopls", -- go
          "neocmake", -- cmake
          "marksman", -- markdown
          "tinymist", -- typst
          "texlab", -- LaTeX
          "kotlin_lsp", -- kotlin
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
          -- Debuggers
          "java-debug-adapter",
          "java-test",
          "cpptools", -- c, cpp
          "codelldb", -- c, cpp, rust
          "debugpy", -- python
          "js-debug-adapter", -- javascript, typescript
          "firefox-debug-adapter", -- javascript, typescript
          "kotlin-debug-adapter",
          "delve", -- go
          "php-debug-adapter",
          -- Formatters & Linters
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
          "sqlfluff", -- sql fmt/lint
          -- "vale", -- tex lint
          "prettypst", -- typst fmt
          "bibtex-tidy", -- tex fmt
          -- "xmlformatter", -- xml fmt
          -- "yamllint", -- yaml lint
          "shellcheck",
          "shellharden",
        },
      }
    end,
  },
}
