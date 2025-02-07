return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "onedark"

    local config = {
      style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    }

    local onedark = require "onedark"
    onedark.setup(config)
    onedark.load()

    local toggle_transparency = function()
      config.transparent = not config.transparent
      onedark.setup(config)
      onedark.load()
    end

    vim.keymap.set(
      "n",
      "<leader>at",
      toggle_transparency,
      { noremap = true, silent = true, desc = "Toggle Background Transparency" }
    )
    vim.keymap.set(
      "n",
      "<leader>as",
      ':lua require("onedark").toggle()<CR>',
      { silent = true, desc = "Toggle Onedark-theme Style" }
    )
  end,
}
