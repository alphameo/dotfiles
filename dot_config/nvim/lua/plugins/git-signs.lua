return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  event = { "VeryLazy" },
  config = function()
    local map = vim.keymap.set
    require("gitsigns").setup {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = true,
      word_diff = false,
    }

    map("n", "<leader>gb", ":Gitsigns blame<CR>", { silent = true, desc = "Git Blame" })
    map("n", "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", { silent = true, desc = "Git Blame Line" })
    map("n", "<leader>gh", ":Gitsigns preview_hunk_inline<CR>", { silent = true, desc = "Git Hunk Preview" })
    map("n", "<leader>gw", ":Gitsigns toggle_word_diff<CR>", { silent = true, desc = "Git Word Diff" })
    map("n", "]h", ":Gitsigns nav_hunk next<CR>", { silent = true, desc = "Git Hunk Next" })
    map("n", "[h", ":Gitsigns nav_hunk prev<CR>", { silent = true, desc = "Git Hunk Prev" })
    map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Git Toggle Stage Hunk" })
    map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, desc = "Git Hunk Reset" })
  end,
}
