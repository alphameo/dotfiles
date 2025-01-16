return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>bf",
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      { silent = true, desc = "Harpoon Mark File" }
    )

    vim.keymap.set("n", "<leader>bm", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon Menu" })
  end,
}
