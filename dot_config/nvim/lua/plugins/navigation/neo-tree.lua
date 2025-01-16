return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              buftype = { "terminal", "quickfix" },
            },
          },
        }
      end,
    },
  },
  config = function()
    vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup {
      close_if_last_window = true,
      popup_border_style = "rounded",
      default_component_configs = {
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "",
          highlight = "NeoTreeFileIcon",
        },
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
        toggle = false,
      }
    end, { noremap = true, desc = "File Explorer" })

    vim.keymap.set("n", "<C-S-e>", function()
      require("neo-tree.command").execute {
        action = "focus",
        source = "filesystem",
        position = "left",
        reveal = true,
        toggle = true,
      }
    end, { noremap = true, desc = "Toggle File Explorer" })

    vim.keymap.set("n", "<leader>Gs", function()
      require("neo-tree.command").execute {
        action = "focus",
        source = "git_status",
        position = "float",
      }
    end, { noremap = true, desc = "Git Status window" })
  end,
}
