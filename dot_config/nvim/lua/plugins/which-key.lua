return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    preset = "helix", -- "classic" | "modern" | "helix"
    layout = { align = "center" },
    title = true,
    title_pos = "center",
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
  },
  config = function(_, opts)
    local which_key = require "which-key"

    which_key.setup(opts)

    which_key.add {
      { "<leader>a", group = "Appearance", mode = { "n", "v" }, icon = { icon = " ", color = "blue" } },
      { "<leader>c", group = "Code", mode = { "n", "v" }, icon = { icon = " ", color = "gray" } },
      { "<leader>d", group = "Debug", mode = { "n", "v" } },
      { "<leader>g", group = "Git", mode = { "n", "v" }, icon = { icon = "󰊢 ", color = "orange" } },
      { "<leader>M", group = "Mason", mode = { "n", "v" }, icon = { icon = " ", color = "green" } },
      { "<leader>L", group = "Lazy", mode = { "n", "v" }, icon = { icon = " ", color = "green" } },
      { "<leader>l", group = "LSP", mode = { "n", "v" }, icon = { icon = "󰰍 ", color = "white" } },
      { "<leader>r", group = "Refactor", mode = { "n", "v" }, icon = { icon = " ", color = "gray" } },
      { "<leader>f", group = "Find", mode = { "n", "v" }, icon = { icon = " ", color = "cyan" } },
      { "<leader>.", group = "Settings", mode = { "n", "v" }, icon = { icon = " ", color = "white" } },
      { "<leader>F", group = "Find & Replace", mode = { "n", "v" }, icon = { icon = "󰛔 ", color = "cyan" } },
      { "<leader>n", group = "Noice", mode = { "n", "v" }, icon = { icon = "󱅫 ", color = "yellow" } },

      { "<leader>s", group = "Snapshot", mode = { "v" }, icon = { icon = "󰄀 ", color = "white" } },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "z", group = "fold" },

      vim.keymap.set("n", "<leader>.?", function()
        which_key.show { global = false }
      end, { desc = "Buffer Local Keymaps (which-key)" }),
    }
  end,
}
