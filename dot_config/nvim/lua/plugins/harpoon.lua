return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local harpoon = require "harpoon"
    local keys = {
      {
        "<leader>hf",
        function()
          harpoon:list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>hh",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Menu",
      },
    }
    return keys
  end,
}
