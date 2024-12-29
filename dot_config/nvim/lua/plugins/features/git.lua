return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true, -- disable by default, enabled only on keymap
      date_format = "%m/%d/%y %H:%M:%S", -- more concise date format
    },

    vim.keymap.set(
      "n",
      "<leader>GB",
      ":GitBlameToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle Git Blame" }
    ),
  },
  {
    -- Git side status
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
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
    },
  },
  {
    -- GitHub integration for vim-fugitive
    "tpope/vim-rhubarb",
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>Ga", "Git add", { desc = "Git Add" })
      vim.keymap.set("n", "<leader>GA", ":Git add .<cr>", { desc = "Git Add All" })
      vim.keymap.set("n", "<leader>Gb", ":Git blame<cr>", { desc = "Git Blame" })
      vim.keymap.set("n", "<leader>Gc", ":Git commit", { desc = "Git Commit" })
      vim.keymap.set("n", "<leader>Gp", "Git push", { desc = "Git Push" })
    end,
  },
}
