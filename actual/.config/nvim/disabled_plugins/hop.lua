return {
  "smoka7/hop.nvim",
  version = "*",
  config = function()
    local hop = require "hop"
    hop.setup {
      keys = "etovxqpdygfblzhckisuran",
    }
    vim.keymap.set("n", "gW", ":HopWord<CR>", { desc = "Goto Word" })
  end,
}
