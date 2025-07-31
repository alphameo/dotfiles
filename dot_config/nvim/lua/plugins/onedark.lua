return {
  "navarasu/onedark.nvim",
  lazy = false,
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

    vim.api.nvim_set_hl(0, "MiniTablineCurrent", { fg = "#abb2bf", bg = "#282c34", bold = true })
    vim.api.nvim_set_hl(0, "MiniTablineVisible", { fg = "#5c6370", bg = "#24282f" })
    vim.api.nvim_set_hl(0, "MiniTablineHidden", { fg = "#5c6370", bg = "#1e2127" })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedCurrent", { fg = "#d19a66", bg = "#282c34", bold = true, italic = true })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedVisible", { fg = "#e5c07b", bg = "#24282f", italic = true })
    vim.api.nvim_set_hl(0, "MiniTablineModifiedHidden", { fg = "#e5c07b", bg = "#1e2127", italic = true })
    vim.api.nvim_set_hl(0, "MiniTablineFill", { fg = "#5c6370", bg = "#16181c" })

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
