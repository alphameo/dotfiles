return {
  "nmac427/guess-indent.nvim",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("guess-indent").setup {}

    vim.api.nvim_create_user_command("Indent", "GuessIndent", { desc = "Guess Indent" })
  end,
}
