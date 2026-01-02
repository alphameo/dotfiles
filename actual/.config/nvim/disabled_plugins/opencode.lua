return {
  "NickvanDyke/opencode.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
    local map = vim.keymap.set
    local opencode = require "opencode"

    map({ "n", "t" }, "<M-`>", function()
      opencode.toggle()
    end, { desc = "AI Agent" })
    map({ "n", "x" }, "gaa", function()
      opencode.select()
    end, { desc = "Opencode actions" })

    map({ "n", "x" }, "gar", function()
      return opencode.operator "@this "
    end, { expr = true, desc = "Opencode add range" })
    map("n", "gal", function()
      return opencode.operator "@this " .. "_"
    end, { expr = true, desc = "Opencode add line" })
  end,
}
