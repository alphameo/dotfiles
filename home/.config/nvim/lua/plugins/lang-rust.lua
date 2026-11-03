return {
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    ft = { "rust" },
    lazy = true,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          vim.keymap.set("n", "<leader>a", function()
            vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
            -- or vim.lsp.buf.codeAction() if you don't want grouping.
          end, { silent = true })
          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp { "hover", "actions" }
          end, { silent = true })
        end,
      })
    end,
  },
  {
    "Saecki/crates.nvim",
    lazy = true,
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup {
        completion = {
          crates = {
            enabled = true,
          },
        },
        lsp = {
          enabled = true,
          actions = true,
          completion = true,
          hover = true,
        },
      }
    end,
  },
}
