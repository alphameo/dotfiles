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
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged_enable = true,
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      blame_formatter = nil, -- Use default
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    }

    local gitsigns = require "gitsigns"

    map("n", "<leader>gb", ":Gitsigns blame<CR>", { silent = true, desc = "Git Blame" })
    map("n", "gh", gitsigns.preview_hunk_inline, { silent = true, desc = "Git Hunk Preview Inline" })
    map("n", "gH", gitsigns.preview_hunk, { silent = true, desc = "Git Hunk Preview Window" })
    map("n", "]h", ":Gitsigns nav_hunk next<CR>", { silent = true, desc = "Go to Next git Hunk" })
    map("n", "[h", ":Gitsigns nav_hunk prev<CR>", { silent = true, desc = "Go to Previous git Hunk" })
    map("n", "<leader>gs", gitsigns.stage_hunk, { silent = true, desc = "Toggle Git Stage Hunk" })
    map("n", "<leader>gr", gitsigns.reset_hunk, { silent = true, desc = "Git Reset Hunk" })
    map("n", "<leader>gS", gitsigns.stage_buffer, { silent = true, desc = "Toggle Git Stage Buffer" })
    map("n", "<leader>gR", gitsigns.reset_buffer, { silent = true, desc = "Git Reset Buffer" })
    map("n", "<leader>gH", gitsigns.setqflist, { desc = "Git Hunk List" })
    map("n", "<leader>gD", ":Gitsigns show ", { desc = "Git show <REVISION>" })
    map("n", "<leader>gd", ":Gitsigns diffthis  ", { desc = "Git diff with <REVISION>" })
    map("n", "<leader>gb", ":Gitsigns change_base ", { desc = "Git Change Base <REVISION>" })

    cmd("GitBlame", gitsigns.toggle_current_line_blame, { desc = "Toggle Git Blame Line" })
    cmd("GitWordDiff", gitsigns.toggle_word_diff, { desc = "Toggle Git Word Diff" })
  end,
}
