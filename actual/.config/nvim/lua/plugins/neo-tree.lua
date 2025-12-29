return {
  {
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
            ["<C-w>s"] = "open_split",
            ["<C-w>v"] = "open_vsplit",
            ["h"] = "close_node",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
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
      end, { desc = "File Explorer" })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Uncomment whichever supported plugin(s) you use
      -- "nvim-tree/nvim-tree.lua",
      "nvim-neo-tree/neo-tree.nvim",
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
