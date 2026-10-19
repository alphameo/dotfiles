return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catppuccin = require "catppuccin"
    local config = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      float = {
        transparent = false,
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      lsp_styles = {
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = false,
      auto_integrations = true,
      -- https://github.com/catppuccin/nvim#integrations
      integrations = {
        cmp = true,
        gitsigns = true,
        neotree = true,
        fidget = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    }

    catppuccin.setup(config)
    vim.cmd.colorscheme "catppuccin-nvim"

    local toggle_transparency = function()
      config.transparent = not config.float.transparent
      catppuccin.setup(config)
    end

    vim.keymap.set(
      "n",
      "<leader>.t",
      toggle_transparency,
      { noremap = true, silent = true, desc = "Toggle Background Transparency" }
    )
  end,
}
