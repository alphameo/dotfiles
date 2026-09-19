-- system deps: `chafa`, `viu`, `ueberzugpp`
return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    -- "nvim-mini/mini.nvim",
  },
  lazy = true,
  event = "VeryLazy",
  config = function()
    local fzf = require "fzf-lua"
    fzf.setup {
      "default",
      keymap = {
        builtin = {
          false, -- inherit defaults
          ["<M-Esc>"] = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<F5>"] = "toggle-preview-cw", -- Rotate preview clockwise/counter-clockwise
          ["<F6>"] = "toggle-preview-behavior", -- Preview toggle behavior default/extend
          ["<C-e>"] = "preview-down",
          ["<C-y>"] = "preview-up",
        },
        fzf = {
          false, -- inherit defaults
          ["ctrl-z"] = "abort",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "toggle-all",
          ["ctrl-space"] = "toggle",
          ["ctrl-l"] = "select-all+accept",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
        },
      },
      actions = {
        files = {
          false, -- inherit defaults
          -- Pickers inheriting these actions:
          --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
          --   tags, btags, args, buffers, tabs, lines, blines
          ["enter"] = fzf.actions.file_edit_or_qf, -- opens a single selection or sends multiple selection to quickfix
          ["ctrl-s"] = fzf.actions.file_split,
          ["ctrl-v"] = fzf.actions.file_vsplit,
          ["alt-i"] = fzf.actions.toggle_ignore,
          ["alt-h"] = fzf.actions.toggle_hidden,
          ["alt-f"] = fzf.actions.toggle_follow,
        },
      },
      grep = {
        grep_opts = "--dereference-recursive --binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        rg_opts = "--follow --no-ignore --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        hidden = true,
      },
      files = {
        git_icons = true,
        hidden = true,
      },
    }

    local lsp_act = require("lsp").actions
    lsp_act.def = fzf.lsp_definitions
    lsp_act.decl = fzf.lsp_declarations
    lsp_act.impl = fzf.lsp_implementations
    lsp_act.ref = fzf.lsp_references
    lsp_act.type_def = fzf.lsp_typedefs
    lsp_act.doc_symb = fzf.lsp_document_symbols
    lsp_act.wsp_symb = fzf.lsp_workspace_symbols
    lsp_act.in_calls = fzf.lsp_incoming_calls
    lsp_act.out_calls = fzf.lsp_outgoing_calls

    local map = vim.keymap.set
    map("n", "<leader>fp", fzf.builtin, { desc = "Find Picker" })

    map("n", "grR", fzf.lsp_finder, { desc = "Find all locations" })

    map("n", "<leader>ff", fzf.files, { desc = "Find Files" })
    map("n", "<leader>fg", fzf.live_grep, { desc = "Find by Grep" })
    map("n", "<leader>fw", fzf.grep_cword, { desc = "Find Words" })
    map("n", "<leader>fr", fzf.oldfiles, { desc = "Find Recent Files" })

    map("n", "<leader>fm", fzf.marks, { desc = "Find Marks" })
    map("n", "<leader>fb", fzf.buffers, { desc = "Find Buffers" })
    map("n", "<leader>ft", fzf.tabs, { desc = "Find Tabs" })
    map("n", "<leader>fj", fzf.jumps, { desc = "Find in Jump List" })
    map("n", "<leader>fq", fzf.quickfix, { silent = true, desc = "Find in Quickfix List" })
    map("n", "<leader>fQ", fzf.quickfix_stack, { silent = true, desc = "Find in Quickfix List History" })
    map("n", "<leader>fd", fzf.diagnostics_document, { silent = true, desc = "Find in document Diagnostics" })
    map("n", "<leader>fD", fzf.diagnostics_workspace, { silent = true, desc = "Find in workspace Diagnostics" })

    map("n", "<leader>fh", fzf.git_hunks, { desc = "Find Git Hunks" })
    map("n", "<leader>fH", fzf.git_status, { desc = "Find Git Status" })

    map("n", "<leader>.c", fzf.colorschemes, { desc = "Choose Colorscheme" })
    map("n", "<leader>.K", fzf.keymaps, { desc = "Inspect Keymapping" })
  end,
}
