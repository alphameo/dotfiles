return {
  "nmac427/guess-indent.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.keymap.set({ "n" }, "<leader>ci", ":GuessIndent<CR>", { silent = true, desc = "Code Detect Indent" })
    require("guess-indent").setup {}
  end,
}
