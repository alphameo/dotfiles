return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope").setup {
        defaults = {
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
      require("telescope").load_extension "ui-select"

      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by Grep" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Words" })
      vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Find Recent Files" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help Tags" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })

      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "Neovim Config" })
    end,
  },
}
