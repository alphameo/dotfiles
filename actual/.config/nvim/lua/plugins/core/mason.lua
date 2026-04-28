-- Binaries
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

vim.keymap.set({ "n" }, "<leader>M", ":Mason<CR>", { silent = true, desc = "Mason" })

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    lazy = true,
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function()
      require("mason").setup {
        registries = {
          "github:mason-org/mason-registry", -- for roslyn
          "github:Crashdummyy/mason-registry", -- for roslyn
        },
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
          "golangci-lint-langserver", -- golangci-lint
          "gopls", -- go
          "neocmake", -- cmake
          "marksman", -- markdown
          "tinymist", -- typst
          "texlab", -- LaTeX
          "kotlin_lsp", -- kotlin
          "html", -- html
          "hyprls", -- hyprlang
          "cssls", -- css
          "cssmodules_ls", -- css
          "docker-compose-language-service", -- docker
          "dockerfile-language-server", -- docker
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
          -- "bacon-ls", -- rust
          "roslyn", -- c#
          -- Debuggers
          "java-debug-adapter",
          "java-test",
          "cpptools", -- c, cpp
          "codelldb", -- c, cpp, rust
          "netcoredbg", -- c#
          "debugpy", -- python
          "js-debug-adapter", -- javascript, typescript
          "firefox-debug-adapter", -- javascript, typescript
          "kotlin-debug-adapter", -- kotlin
          "delve", -- go
          "php-debug-adapter", -- php
          -- Formatters & Linters
          "prettierd", -- ts, js, ... fmt
          "eslint_d", -- ts, js, ... lint
          -- "jq", -- json fmt
          "stylua", -- lua fmt
          "luacheck", -- lua lint
          "kdlfmt", -- kdl formatter
          "ktlint", -- kotlin fmt/lint
          -- "detekt", -- kotlin lint
          "hadolint", -- docker lint
          "clang-format", -- c, cpp fmt
          "cpplint", -- c, cpp lint
          "gersemi", -- cmake fmt
          "cmakelint", -- cmake lint
          "checkmake", -- makefile lint
          "ruff", -- python fmt
          "black", -- python fmt
          "mypy", -- python lint
          "markdownlint-cli2", -- markdown fmt/lint
          "markdown-toc", -- markdown fmt
          "gofumpt", -- go fmt
          "goimports", -- go fmt
          -- "golangci-lint", -- go lint
          "php-cs-fixer", -- php fmt
          "phpcs", -- php lint
          "rustfmt", -- rust fmt
          -- "bacon", -- rust lint
          -- "shfmt", -- bash, zsh, sh fmt
          -- "stylelint", -- css lint
          "htmlhint", -- html lint
          "sqlfluff", -- sql fmt/lint
          -- "csharpier", -- c# fmt
          -- "vale", -- tex lint
          "prettypst", -- typst fmt
          "bibtex-tidy", -- tex fmt
          -- "xmlformatter", -- xml fmt
          -- "yamllint", -- yaml lint
          -- "shellcheck",
          -- "shellharden",
          -- Tools
          "gomodifytags", -- for gopher.nvim
          "gotests", -- for gopher.nvim
          "iferr", -- for gopher.nvim
          "impl", -- for gopher.nvim
        },
      }
    end,
  },
}
