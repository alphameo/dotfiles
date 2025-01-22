return {
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      date_format = "%m/%d/%y %H:%M:%S",
    },

    vim.keymap.set(
      "n",
      "<leader>gB",
      ":GitBlameToggle<CR>",
      { noremap = true, silent = true, desc = "Git Blame Line" }
    ),
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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
    "tpope/vim-rhubarb",
  },
  {
    "tpope/vim-fugitive",
    config = function()
      local map = vim.keymap.set

      map("n", "<leader>ga", "Git add", { silent = true, desc = "Git Add" })
      map("n", "<leader>gA", ":Git add .<cr>", { silent = true, desc = "Git Add All" })
      map("n", "<leader>gb", ":Git blame<cr>", { silent = true, desc = "Git Blame" })
      map("n", "<leader>gc", ":Git commit<cr>", { silent = true, desc = "Git Commit" })
      map("n", "<leader>gp", ":Git push<cr>", { silent = true, desc = "Git Push" })
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
