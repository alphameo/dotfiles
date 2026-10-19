return {
  "moll/vim-bbye",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<C-q>", ":Bdelete<CR>", { silent = true, desc = "Close buffer" })
  end,
}
