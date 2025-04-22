return {
  "tpope/vim-fugitive",
  lazy = true,
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
    "Gmove",
    "Gdelete",
    "Gbrowse",
  },
  config = function()
    local map = vim.keymap.set

    map("n", "<leader>ga", "Git add", { silent = true, desc = "Git Add" })
    map("n", "<leader>gA", ":Git add .<cr>", { silent = true, desc = "Git Add All" })
    map("n", "<leader>gb", ":Git blame<cr>", { silent = true, desc = "Git Blame" })
    map("n", "<leader>gc", ":Git commit<cr>", { silent = true, desc = "Git Commit" })
    map("n", "<leader>gp", ":Git push<cr>", { silent = true, desc = "Git Push" })
  end,
}
