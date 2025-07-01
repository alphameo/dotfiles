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
        cpp = { "clang_format" },
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

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      local fmt_range
      if args.count ~= -1 then
        fmt_range = args.line1 .. "-" .. args.line2
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      else
        fmt_range = "whole file"
      end
      conform.format { async = true, lsp_format = "fallback", range = range }
      vim.notify("Lines for formatting: " .. fmt_range)
    end, { range = true })

    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    local map = vim.keymap.set
    map({ "n", "v" }, "<C-S-i>", ":Format<CR>", { silent = true, desc = "Code Format" })
    map({ "n", "v" }, "<leader>cf", ":Format<CR>", { silent = true, desc = "Code Format" })
  end,
}
