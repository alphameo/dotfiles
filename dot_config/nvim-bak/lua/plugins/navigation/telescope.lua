return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable "make" == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
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

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by Grep" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Words" })
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Find Recent Files" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
    -- vim.keymap.set("n", "<leader>ft", builtin.builtin, { desc = "Telescope Builtins" })
    -- vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
    -- vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
    -- vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

    -- vim.keymap.set("n", "<leader>fz", function()
    --   builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    --     winblend = 10,
    --     previewer = false,
    --   })
    -- end, { desc = "Fuzzy Find in current buffer" })

    -- vim.keymap.set("n", "<leader>fG", function()
    --   builtin.live_grep {
    --     grep_open_files = true,
    --     prompt_title = "Find by Live Grep in Open Files",
    --   }
    -- end, { desc = "Find in Open Files" })

    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "Find Neovim Files" })
  end,
}
