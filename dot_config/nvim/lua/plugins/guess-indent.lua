return {
  "nmac427/guess-indent.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("guess-indent").setup {}

    vim.keymap.set("n", "<leader>ci", ":GuessIndent<CR>", { silent = true, desc = "Code Detect Indent" })
  end,
}
