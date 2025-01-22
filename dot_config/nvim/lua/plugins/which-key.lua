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

    which_key.add {
      { "<leader>a", group = "Appearance", mode = { "n", "v" }, icon = { icon = " ", color = "blue" } },
      { "<leader>c", group = "Code", mode = { "n", "v" }, icon = { icon = " ", color = "gray" } },
      { "<leader>cs", group = "Code Simbols", mode = { "n", "v" } },
      { "<leader>d", group = "Debug", mode = { "n", "v" } },
      { "<leader>g", group = "Git", mode = { "n", "v" }, icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>h", group = "Harpoon Bookmarks", mode = { "n", "v" }, icon = { icon = "󰸕 ", color = "yellow" } },
      { "<leader>M", group = "Mason", mode = { "n", "v" }, icon = { icon = " ", color = "green" } },
      { "<leader>l", group = "LSP", mode = { "n", "v" }, icon = { icon = "󰰍 ", color = "white" } },
      { "<leader>r", group = "Refactor", mode = { "n", "v" }, icon = { icon = " ", color = "gray" } },
      { "<leader>f", group = "Telescope Find", mode = { "n", "v" }, icon = { icon = " ", color = "cyan" } },
      { "<leader>s", group = "Settings", mode = { "n", "v" }, icon = { icon = " ", color = "white" } },
      { "<leader>F", group = "Spectre Find & Replace", mode = { "n", "v" }, icon = { icon = "󰛔 ", color = "cyan" } },
      { "<leader>x", group = "Trouble", mode = { "n", "v" }, icon = { icon = " ", color = "yellow" } },
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
      "<leader>s?",
      function()
        require("which-key").show { global = false }
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
