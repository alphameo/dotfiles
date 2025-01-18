return {
  -- FORMAT
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require "conform"

      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          c = { "clang_format" },
          cpp = { "clang_format" },
          -- cmake = { "cmakelang" },
          kotlin = { "ktlint" },
          markdown = { "prettierd", "markdownlint-cli2", "markdown-toc" },
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
          go = { "goimports", "gofumpt" },
          php = { "php_cs_fixer" },
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
  },

  -- LINT
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        kotlin = { "ktlint" },
        cpp = { "cpplint" },
        cmake = { "cmakelint" },
        python = { "mypy" },
        markdown = { "markdownlint-cli2" },
        sql = { "sqlfluff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        php = { "phpcs" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cF", function()
        lint.try_lint()
      end, { desc = "Trigger linting" })
    end,
  },
}
