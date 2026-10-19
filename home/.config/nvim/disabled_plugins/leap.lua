return {
  "https://codeberg.org/andyg/leap.nvim",
  event = "VeryLazy",
  config = function()
    local leap = require "leap"

    leap.opts.safe_labels = ""
    leap.opts.preview = false

    leap.opts.preview = function(ch0, ch1, ch2)
      return not (ch1:match "%s" or (ch0:match "%a" and ch1:match "%a" and ch2:match "%a"))
    end

    vim.keymap.set({ "n", "x", "o" }, "gw", "<Plug>(leap)")
    vim.keymap.set("n", "gW", "<Plug>(leap-from-window)")
  end,
}
