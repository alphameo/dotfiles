return {
  "lewis6991/gitsigns.nvim",
  lazy = true,
  event = { "VeryLazy" },
  config = function()
    local map = vim.keymap.set
    local cmd = vim.api.nvim_create_user_command
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
    map("n", "gh", ":Gitsigns preview_hunk_inline<CR>", { silent = true, desc = "Git Hunk Preview" })
    map("n", "]h", ":Gitsigns nav_hunk next<CR>", { silent = true, desc = "Go to Next git Hunk" })
    map("n", "[h", ":Gitsigns nav_hunk prev<CR>", { silent = true, desc = "Go to Previous git Hunk" })
    map("n", "\\h", ":Gitsigns stage_hunk<CR>", { silent = true, desc = "Toggle Git Stage Hunk" })
    map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { silent = true, desc = "Git Reset Hunk" })

    cmd("GitBlame", "Gitsigns toggle_current_line_blame", { desc = "Toggle Git Blame Line" })
    cmd("GitWordDiff", "Gitsigns toggle_word_diff", { desc = "Toggle Git Word Diff" })
  end,
}
