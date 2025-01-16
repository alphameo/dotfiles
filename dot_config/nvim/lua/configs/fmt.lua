return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require "null-ls"
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require("mason-null-ls").setup {
      ensure_installed = {
        "prettierd", -- ts/js formatter
        "eslint_d", -- ts/js linter
        "stylua", -- lua formatter
        "shfmt", -- Shell formatter
        "checkmake", -- linter for Makefiles
        "ktlint",
        "cmakelang",
        -- "clang-format",
        -- "cpplint",
        "ruff",
        "mypy",
        "black",
      },
      automatic_installation = true,
    }

    local sources = {
      formatting.stylua,
      formatting.ktlint,
      diagnostics.ktlint,
      formatting.prettierd.with {
        filetypes = {
          "css",
          "graphql",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "less",
          "scss",
          "typescript",
          "typescriptreact",
          "yaml",
        },
      },
      require "none-ls.diagnostics.eslint_d",
      diagnostics.checkmake,
      formatting.shfmt.with { args = { "-i", "4" } },
      -- formatting.clang_format.with {
      --   filetypes = { "c", "cpp" },
      -- },
      -- require "none-ls.diagnostics.cpplint",
      diagnostics.mypy,
      require("none-ls.formatting.ruff").with { extra_args = { "--extend-select", "I" } },
      require "none-ls.formatting.ruff_format",
      formatting.black,
    }

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    null_ls.setup {
      debug = true, -- Enable debug mode. Inspect logs with :NullLsLog.
      sources = sources,

      vim.keymap.set({ "n", "v", "i" }, "<C-S-i>", vim.lsp.buf.format, { desc = "Code Format" }),
      vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "Code Format" }),
    }
  end,
}
