return {
  "nmac427/guess-indent.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { mode = "n", "<leader>ci", ":GuessIndent<CR>", silent = true, desc = "Code Detect Indent" },
  },
  opts = {},
}
