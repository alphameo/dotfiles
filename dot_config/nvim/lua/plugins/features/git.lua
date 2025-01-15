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
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>GG", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
