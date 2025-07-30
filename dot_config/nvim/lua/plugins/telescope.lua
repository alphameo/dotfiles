return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
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
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true,
            override_file_sorter = true,
            -- "smart_case" | "ignore_case" | "respect_case"
            case_mode = "smart_case",
          },
        },
      }
      telescope.load_extension "ui-select"
      telescope.load_extension "fzf"

      local builtin = require "telescope.builtin"

      local lsp_act = require("lsp").actions
      lsp_act.def = builtin.lsp_definitions
      lsp_act.impl = builtin.lsp_implementations
      lsp_act.ref = builtin.lsp_references
      lsp_act.type_def = builtin.lsp_type_definitions
      lsp_act.doc_symb = builtin.lsp_document_symbols
      lsp_act.wsp_symb = builtin.lsp_dynamic_workspace_symbols

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
      end, { desc = "Neovim Config Files" })
    end,
  },
}
