return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    branch = "0.1.x",
    lazy = true,
    event = "VeryLazy",
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
      map("n", "<leader>ac", ":Telescope colorscheme<CR>", { silent = true, desc = "Choose Colorscheme" })
      map("n", "<leader>fp", ":Telescope<CR>", { silent = true, desc = "Find Picker" })
      map("n", "<leader>fm", ":Telescope marks<CR>", { silent = true, desc = "Find Marks" })
      map("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true, desc = "Find Buffers" })
      map("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true, desc = "Find Files" })
      map("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true, desc = "Find by Grep" })
      map("n", "<leader>fw", ":Telescope grep_string<CR>", { silent = true, desc = "Find Words" })
      map("n", "<leader>fr", ":Telescope oldfiles<CR>", { silent = true, desc = "Find Recent Files" })
      map("n", "<leader>.h", ":Telescope help_tags<CR>", { silent = true, desc = "Help Tags" })
      map("n", "<leader>.k", ":Telescope keymaps<CR>", { silent = true, desc = "eymaps" })

      map("n", "<leader>.n", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "Neovim Config" })
    end,
  },
}
