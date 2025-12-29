return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
    local map = vim.keymap.set
    local opencode = require "opencode"

    map({ "n", "t" }, "<leader>o", function()
      opencode.toggle()
    end, { desc = "Opencode" })
    map({ "n", "x" }, "goa", function()
      opencode.select()
    end, { desc = "Opencode actions" })

    map({ "n", "x" }, "gor", function()
      return opencode.operator "@this "
    end, { expr = true, desc = "Opencode add range" })
    map("n", "gol", function()
      return opencode.operator "@this " .. "_"
    end, { expr = true, desc = "Opencode add line" })
  end,
}
