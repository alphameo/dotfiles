return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "onedark"

    local config = {
      -- Main options --
      style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      transparent = true, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      -- toggle_style_key = "<leader>as", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {
        -- purple = '#56b6c2',
      }, -- Override default colors
      highlights = {}, -- Override highlight groups

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    }

    local onedark = require "onedark"
    onedark.setup(config)
    onedark.load()

    -- Make the background of diagnostics messages transparent
    local set_diagnostics_bg_transparency = function()
      vim.cmd [[highlight DiagnosticVirtualTextError guibg=none]]
      vim.cmd [[highlight DiagnosticVirtualTextWarn guibg=none]]
      vim.cmd [[highlight DiagnosticVirtualTextInfo guibg=none]]
      vim.cmd [[highlight DiagnosticVirtualTextHint guibg=none]]
    end
    set_diagnostics_bg_transparency()

    -- Toggle background transparency
    local toggle_transparency = function()
      config.transparent = not config.transparent
      onedark.setup(config)
      onedark.load()
      set_diagnostics_bg_transparency()
    end

    toggle_transparency()

    vim.keymap.set(
      "n",
      "<leader>at",
      toggle_transparency,
      { noremap = true, silent = true, desc = "Toggle Background Transparency" }
    )
    vim.keymap.set(
      "n",
      "<leader>as",
      '<Cmd>lua require("onedark").toggle()<CR>',
      { silent = true, desc = "Toggle Onedark-theme Style" }
    )
  end,
}
