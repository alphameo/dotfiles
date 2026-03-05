return {
  "rcarriga/nvim-notify",
  lazy = true,
  event = "VeryLazy",
  config = function()
    local notify = require "notify"
    notify.setup()
    vim.notify = notify
  end,
}
