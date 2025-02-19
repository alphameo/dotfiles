return {
  "f-person/git-blame.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    date_format = "%m/%d/%y %H:%M:%S",
  },
  config = function()
    vim.keymap.set("n", "<leader>gB", ":GitBlameToggle<CR>", { noremap = true, silent = true, desc = "Git Blame Line" })
  end,
}
