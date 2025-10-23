return {
  {
    "mbbill/undotree",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true, desc = "Undo Tree" })
    end,
  },
}
