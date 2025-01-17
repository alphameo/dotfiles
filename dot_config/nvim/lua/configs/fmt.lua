return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require "conform"

    conform.setup {
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        graphql = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
        xml = { "xmlformatter" },
        lua = { "stylua" },
        python = { "ruff", "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- cmake = { "cmakelang" },
        kotlin = { "ktlint" },
        sql = { "sqlfluff" },
      },
    }

    vim.keymap.set({ "n", "v", "i" }, "<C-S-i>", function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = "Code Format" })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      }
    end, { desc = "Code Format" })
  end,
}
