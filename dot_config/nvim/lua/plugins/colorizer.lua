return {
  "norcalli/nvim-colorizer.lua",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("colorizer").setup {
      "*",
      css = {
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
      },
    }
    vim.keymap.set("n", "<leader>aC", ":ColorizerToggle<CR>", { silent = true, desc = "Toggle Colorizer" })
  end,
}
