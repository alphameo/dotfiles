return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require "conform"
    conform.setup {
      formatters_by_ft = {
        bash = { "shfmt" },
        zsh = { "shfmt" },
        sh = { "shfmt" },
        c = { "clang_format" },
        cmake = { "gersemi" },
        css = { "prettierd" },
        go = { "gofumpt", "goimports" },
        html = { "prettierd" },
        json = { "prettierd" },
        kotlin = { "ktlint" },
        lua = { "stylua" },
        markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
        php = { "php_cs_fixer" },
        python = { "black" },
        rust = { "rustfmt" },
        sql = { "sqlfmt" },
        tex = { "bibtex-tidy" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
      },
    }

    conform.formatters = {
      clang_format = {
        args = {
          "--style={BasedOnStyle: Google,"
            .. "UseTab: Never,"
            .. "TabWidth: 4,"
            .. "IndentWidth: 4,"
            .. "InsertNewlineAtEOF: true,"
            .. "IndentCaseLabels: true,"
            .. "LineEnding: LF,"
            .. "BreakBeforeBraces: Attach,"
            .. "AllowShortIfStatementsOnASingleLine: false,"
            .. "AllowShortBlocksOnASingleLine: Empty,"
            .. "IndentAccessModifiers: false,"
            .. "AccessModifierOffset: -3"
            .. "}",
        },
      },
    }
    local fmt = function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end
    vim.keymap.set({ "n", "v", "i" }, "<C-S-i>", fmt, { desc = "Code Format" })
    vim.keymap.set({ "n", "v" }, "<leader>cf", fmt, { desc = "Code Format" })
  end,
}
