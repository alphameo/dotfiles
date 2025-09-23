return {
  "tpope/vim-fugitive",
  lazy = true,
  event = "VeryLazy",
  cmd = {
    "Git",
    "Gstatus",
    "Gcommit",
    "Gpush",
    "Gpull",
    "Gblame",
    "Gmerge",
    "Gdiffsplit",
    "Gvdiffsplit",
    "Gedit",
    "Gsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "Glgrep",
    "GMove",
    "GDelete",
    "GBrowse",
  },
  opts = {},
  config = function()
    local map = vim.keymap.set

    map("n", "<leader>ga", ":Git add", { silent = true, desc = "Git Add" })
    map("n", "<leader>gA", ":Git add .<CR>", { silent = true, desc = "Git Add All" })
    map("n", "<leader>gb", ":Git blame<CR>", { silent = true, desc = "Git Blame" })
    map("n", "<leader>gc", ":Git commit<CR>", { silent = true, desc = "Git Commit" })
    map("n", "<leader>gp", ":Git push<CR>", { silent = true, desc = "Git Push" })
  end,
}
