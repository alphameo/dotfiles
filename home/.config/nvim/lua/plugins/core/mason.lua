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
          -- GO
          "gopls", -- go
          "golangci-lint-langserver", -- golangci-lint
          "delve", -- da
          "gofumpt", -- fmt
          "goimports", -- fmt
          "golangci-lint", -- lint
          "gomodifytags", -- for gopher.nvim
          "gotests", -- for gopher.nvim
          "iferr", -- for gopher.nvim
          "impl", -- for gopher.nvim

          -- LUA
          "lua_ls",
          "stylua", -- fmt
          "luacheck", -- lint

          -- JAVA
          "jdtls",
          "java-debug-adapter", -- da
          "java-test",

          -- -- KOTLIN
          -- "kotlin_lsp", -- kotlin
          -- "kotlin-debug-adapter", -- kotlin
          -- "ktlint", -- kotlin fmt/lint
          -- -- "detekt", -- kotlin lint

          -- -- C#
          -- "roslyn", -- ls
          -- "netcoredbg", -- da
          -- -- "csharpier", -- fmt

          -- C, C++
          "clangd", -- c, cpp
          "cpptools", -- da (+ rust)
          "codelldb", -- da (+ rust + zig)
          "clang-format", -- fmt
          "cpplint", -- lint
          -- RUST
          "rust_analyzer", -- ls
          -- "bacon-ls",
          -- "bacon", -- lint

          -- MAKEFILE
          "checkmake", -- lint

          -- CMAKE
          "neocmake", -- cmake
          "gersemi", -- fmt
          "cmakelint", -- lint

          -- PYTHON
          -- "pyright", -- python
          "basedpyright", -- python static checker
          "debugpy", -- da
          "ruff", -- fmt
          "black", -- fmt
          "mypy", -- lint

          -- -- PHP
          -- "intelephense", -- ls
          -- -- "phpactor", -- ls
          -- "php-debug-adapter", -- da
          -- "php-cs-fixer", -- fmt
          -- "phpcs", -- lint

          -- HTML
          "html", -- ls
          "emmet-language-server", -- emmet for html
          "htmlhint", -- lint

          -- CSS
          "cssls", -- css
          "cssmodules_ls", -- ls
          "css_variables", -- ls
          "tailwindcss-language-server", -- tailwind-css
          -- "stylelint", -- lint

          -- JAVASCRIPT, TYPESCRIPT
          "ts_ls",
          -- "denols",
          -- "vtsls",
          "prettierd", -- fmt
          "eslint_d", -- lint
          "js-debug-adapter", -- da
          "firefox-debug-adapter", -- da

          -- DOCKER
          "docker-compose-language-service",
          "dockerfile-language-server",
          "hadolint", -- lint

          -- KUBERNETES
          "helm-ls", -- helm (kubernetes)

          -- SQL
          "sqlls",
          "sqlfluff", -- fmt/lint

          -- MARKDOWN
          "marksman", -- markdown
          "markdownlint-cli2", -- fmt/lint
          "markdown-toc", -- fmt

          -- TYPST
          "tinymist", -- ls
          -- "prettypst", -- fmt
          "typstyle", -- fmt

          -- LaTeX
          "texlab", -- LaTeX
          -- "vale", -- lint
          "bibtex-tidy", -- fmt

          -- SHELLS
          "bashls",
          "fish-lsp",
          -- "shfmt", -- bash, zsh, sh fmt
          -- "shellcheck", -- bash lint
          -- "shellharden", -- bash fmt/lint

          -- JSON
          "jsonls", -- json
          -- "jq", -- json fmt

          --YAML
          "yamlls", -- yaml
          -- "yamllint", -- yaml lint

          -- TOML
          "taplo", -- toml

          -- KDL
          "kdlfmt", -- kdl formatter

          -- XML
          "lemminx", -- xml
          -- "xmlformatter", -- xml fmt

          -- -- QML
          -- "qmlls", -- qml

          -- MISC
          "harper-ls", -- grammar
          -- "hyprls", -- hyprlang
        },
      }
    end,
  },
}
