return {
  "moll/vim-bbye",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<C-S-q>", ":Bdelete<CR>", { silent = true, desc = "Close buffer" })
  end,
}
