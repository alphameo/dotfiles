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

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      group = vim.api.nvim_create_augroup("InitColorizer", {}),
      desc = "Enables Colorizer on Open File",
      pattern = "*",
      command = "ColorizerToggle",
    })

    vim.keymap.set("n", "<leader>aC", ":ColorizerToggle<CR>", { silent = true, desc = "Toggle Colorizer" })
  end,
}
