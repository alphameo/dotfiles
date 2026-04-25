return {
  "rcarriga/nvim-notify",
  lazy = true,
  event = "VeryLazy",
  config = function()
    local notify = require "notify"
    notify.setup()
    vim.notify = notify

    local map = vim.keymap.set
    map("n", "<leader>nn", ":Notifications<CR>", { silent = true, desc = "Notifications List" })
    map("n", "<leader>nd", ":NotificationsClear<CR>", { silent = true, desc = "Notifications Dismiss All" })
  end,
}
