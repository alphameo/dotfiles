return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require "telescope"
      telescope.setup {
        defaults = {
          prompt_prefix = "   ",
          selection_caret = " ",
          entry_prefix = " ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            width = 0.87,
            height = 0.80,
          },
          mappings = {
            i = {
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-l>"] = require("telescope.actions").select_default, -- open file
            },
          },
        },
        pickers = {
          find_files = {
            file_ignore_patterns = { "node_modules", ".git/", ".venv", ".class" },
            hidden = true,
          },
        },
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git/", ".venv", ".class" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      }
      telescope.load_extension "ui-select"

      local builtin = require "telescope.builtin"
      local map = vim.keymap.set

      map("n", "<leader>ac", builtin.colorscheme, { desc = "Choose Colorscheme" })

      map("n", "<leader>fp", builtin.builtin, { desc = "Find Picker" })
      map("n", "<leader>fm", builtin.marks, { desc = "Find Marks" })
      map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

      map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "Find by Grep" })
      map("n", "<leader>fw", builtin.grep_string, { desc = "Find Words" })
      map("n", "<leader>fr", builtin.oldfiles, { desc = "Find Recent Files" })
      map("n", "<leader>.h", builtin.help_tags, { desc = "Help Tags" })
      map("n", "<leader>.k", builtin.keymaps, { desc = "Keymaps" })
      map("n", "<leader>.n", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "Neovim Config" })
    end,
  },
}
