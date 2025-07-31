return {
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local which_key = require "which-key"

    which_key.setup {
      preset = "helix", -- "classic" | "modern" | "helix"
      layout = { align = "center" },
      title = true,
      title_pos = "center",
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
    }

    which_key.add {
      { "<leader>e", group = "File Tree", mode = { "n", "v" }, icon = { icon = " ", color = "cyan" } },
      { "<leader>u", group = "Undo Tree", mode = { "n", "v" }, icon = { icon = "󰋚 ", color = "cyan" } },
      { "<leader>a", group = "Appearance", mode = { "n", "v" }, icon = { icon = "󰏙 ", color = "blue" } },
      { "<leader>M", group = "Mason", mode = { "n", "v" }, icon = { icon = "󰰐 ", color = "green" } },
      { "<leader>L", group = "Lazy", mode = { "n", "v" }, icon = { icon = " ", color = "green" } },
      { "<leader>ac", mode = { "n", "v" }, icon = { icon = "󰏘 ", color = "orange" } },
      { "<leader>as", mode = { "n", "v" }, icon = { icon = "󰢵 ", color = "orange" } },
      { "<leader>aw", mode = { "n", "v" }, icon = { icon = "󰖶 ", color = "cyan" } },
      { "<leader>at", mode = { "n", "v" }, icon = { icon = "󰊠 ", color = "white" } },
      { "<leader>aC", mode = { "n", "v" }, icon = { icon = "󰉦 ", color = "red" } },
      { "<leader>c", group = "Code", mode = { "n", "v" } },
      { "<leader>d", group = "Debug", mode = { "n", "v" } },
      { "<leader>D", group = "Debug Printf", mode = { "n", "v" } },
      { "<leader>f", group = "Find", mode = { "n", "v" } },
      { "<leader>F", group = "F&Replace", mode = { "n", "v" }, icon = { icon = "󰛔 ", color = "cyan" } },
      { "<leader>g", group = "Git", mode = { "n", "v" } },
      { "<leader>l", group = "LSP", mode = { "n", "v" }, icon = { icon = "󰰍 ", color = "white" } },
      { "<leader>n", group = "Notifications", mode = { "n", "v" } },
      { "<leader>r", group = "Refactor", mode = { "n", "v" } },
      { "<leader>t", group = "Terminal", mode = { "n", "v" } },
      { "<leader>.", group = "Settings", mode = { "n", "v" }, icon = { icon = " ", color = "white" } },

      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "z", group = "fold" },

      vim.keymap.set("n", "<leader>.?", function()
        which_key.show { global = false }
      end, { desc = "Settings Local Keymaps" }),
    }
  end,
}
