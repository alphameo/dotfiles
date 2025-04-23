return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  branch = "v3.x",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("neo-tree").setup {
      close_if_last_window = true,
      popup_border_style = "rounded",
      default_component_configs = {
        modified = {
          symbol = "",
          highlight = "NeoTreeModified",
        },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",

            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["l"] = "open",
          ["L"] = "focus_preview",
          ["s"] = "open_split",
          ["v"] = "open_vsplit",
          ["h"] = "close_node",
        },
      },
    }
    vim.keymap.set("n", "<leader>e", function()
      require("neo-tree.command").execute {
        action = "focus",
        source = "filesystem",
        position = "left",
        reveal = true,
        toggle = true,
      }
    end, { noremap = true, desc = "File Explorer" })
  end,
}
