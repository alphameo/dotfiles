return {
  "Wansmer/treesj",
  lazy = true,
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  keys = {
    { mode = "n", "<leader>cj", ":TSJToggle<CR>", silent = true, desc = "Code Toggle SplitJoin" },
  },
  config = function()
    local tsj = require "treesj"
    tsj.setup {
      use_default_keymaps = false, -- <space>m - toggle, <space>j - join, <space>s - split
      check_syntax_error = true, -- node with syntax error will not be formatted
      max_join_length = 120,
      cursor_behavior = "hold", -- hold | start | end
      notify = true, -- notify about possible problems or notv
      dot_repeat = true, -- use `dot` for repeat action
    }

    -- vim.keymap.set("n", "<leader>cJ", function()
    --   tsj.toggle { split = { recursive = true } }
    -- end, { desc = "Code Toggle SplitJoin Recursively" })
  end,
}
