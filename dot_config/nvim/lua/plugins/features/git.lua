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
      "<leader>GB",
      ":GitBlameToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle Git Blame" }
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
      vim.keymap.set("n", "<leader>Ga", "Git add", { silent = true, desc = "Git Add" })
      vim.keymap.set("n", "<leader>GA", ":Git add .<cr>", { silent = true, desc = "Git Add All" })
      vim.keymap.set("n", "<leader>Gb", ":Git blame<cr>", { silent = true, desc = "Git Blame" })
      vim.keymap.set("n", "<leader>Gc", ":Git commit<cr>", { silent = true, desc = "Git Commit" })
      vim.keymap.set("n", "<leader>Gp", ":Git push<cr>", { silent = true, desc = "Git Push" })
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
      { "<leader>GG", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
