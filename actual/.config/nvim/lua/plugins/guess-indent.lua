return {
  "nmac427/guess-indent.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("guess-indent").setup {}

    vim.keymap.set("n", "gI", ":GuessIndent<CR>", { silent = true, desc = "Detect Indent" })
  end,
}
