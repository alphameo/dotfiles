return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- dependencies = { "nvim-mini/mini.icons" },
  config = function()
    local fzf = require "fzf-lua"
    fzf.setup {
      "default", -- profile
      keymap = {
        fzf = {
          ["ctrl-l"] = "select-all+accept",
        },
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
    map("n", "<leader>fj", fzf.jumps, { desc = "Find in Jump List" })
    map("n", "<leader>fq", fzf.quickfix, { silent = true, desc = "Find in Quickfix List" })
    map("n", "<leader>fQ", fzf.quickfix_stack, { silent = true, desc = "Find in Quickfix List History" })
    map("n", "<leader>fd", fzf.diagnostics_document, { silent = true, desc = "Find in document Diagnostics" })
    map("n", "<leader>fD", fzf.diagnostics_workspace, { silent = true, desc = "Find in workspace Diagnostics" })

    map("n", "<leader>fh", fzf.helptags, { desc = "Find Help Tag" })

    map("n", "<leader>.c", fzf.colorschemes, { desc = "Choose Colorscheme" })
    map("n", "<leader>.k", fzf.keymaps, { desc = "Inspect Keymapping" })
  end,
}
