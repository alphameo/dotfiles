return {
  "f-person/git-blame.nvim",
  lazy = true,
  event = "BufReadPre",
  cmd = { "GitBlameToggle" },
  keys = {
    { mode = "n", "<leader>gB", ":GitBlameToggle<CR>", noremap = true, silent = true, desc = "Git Blame Line" },
  },
  opts = {
    enabled = true,
    date_format = "%m/%d/%y %H:%M:%S",
  },
}
