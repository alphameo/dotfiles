return {
  "Wansmer/treesj",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
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

    local tsj_recursive = function()
      tsj.toggle { split = { recursive = true } }
    end

    vim.keymap.set("n", "grj", tsj.toggle, { desc = "Refactor SplitJoin" })
    vim.keymap.set("n", "grJ", tsj_recursive, { desc = "Refactor recursive SplitJoin" })
  end,
}
