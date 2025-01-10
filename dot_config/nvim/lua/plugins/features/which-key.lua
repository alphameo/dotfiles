return {
  -- Hints keybinds
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    { "echasnovski/mini.icons", version = false },
  },
  config = function()
    local which_key = require "which-key"

    require("mini.icons").setup()

    which_key.setup()

    -- Register prefixes for the different key mappings we have setup previously
    which_key.add {
      { "<leader>a", group = "Appearance", mode = { "n", "v" }, icon = { icon = " ", color = "blue" } },
      { "<leader>c", group = "Code", mode = { "n", "v" }, icon = { icon = " ", color = "gray" } },
      { "<leader>cs", group = "Code Simbols", mode = { "n", "v" } },
      { "<leader>d", group = "Debug", mode = { "n", "v" } },
      { "<leader>g", group = "Goto", mode = { "n", "v" }, icon = { icon = "󰈙 ", color = "white" } },
      { "<leader>G", group = "Git", mode = { "n", "v" }, icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>b", group = "Harpoon Bookmarks", mode = { "n", "v" }, icon = { icon = "󰸕 ", color = "yellow" } },
      { "<leader>m", group = "Markdown", mode = { "n", "v" }, icon = { icon = " ", color = "white" } },
      { "<leader>l", group = "LSP", mode = { "n", "v" }, icon = { icon = "󰰍 ", color = "white" } },
      { "<leader>r", group = "Refactor", mode = { "n", "v" }, icon = { icon = " ", color = "gray" } },
      { "<leader>f", group = "Telescope Find", mode = { "n", "v" }, icon = { icon = "󰈞 ", color = "cyan" } },
      -- { "<leader>t", group = "Tab", mode = { "n", "v" } },
      -- { "<leader>w", group = "Window", mode = { "n", "v" } },
      { "<leader>x", group = "Trouble", mode = { "n", "v" }, icon = { icon = " ", color = "yellow" } },
      -- { "<leader>k", desc = "Show Doc Hover", mode = { "n", "v" }, icon = { icon = "󱔗 ", color = "orange" } },
      -- { "<leader>K", desc = "Show Signature Help", mode = { "n", "v" }, icon = { icon = "󱔗 ", color = "orange" } },
      { "<leader>n", desc = "Noice", mode = { "n", "v" }, icon = { icon = "󱅫 ", color = "yellow" } },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "gs", group = "surround" },
      { "z", group = "fold" },
    }
  end,

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
