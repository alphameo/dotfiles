return {
  "NickvanDyke/opencode.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
    local map = vim.keymap.set
    local opencode = require "opencode"

    map({ "n", "t" }, "<M-`>", function()
      opencode.toggle()
    end, { desc = "AI Agent" })
    map({ "n", "x" }, "<leader>aa", function()
      opencode.select()
    end, { desc = "Opencode Actions" })

    map({ "n", "x" }, "<leader>ar", function()
      return opencode.operator "@this "
    end, { expr = true, desc = "Opencode add Range" })
    map("n", "<leader>al", function()
      return opencode.operator "@this " .. "_"
    end, { expr = true, desc = "Opencode add Line" })
  end,
}
