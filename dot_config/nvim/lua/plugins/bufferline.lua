return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "moll/vim-bbye",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup {
      options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        close_command = "Bdelete! %d", -- mouse action exit (press x) command (string or function)
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "none", -- Options: 'icon', 'underline', 'none'
        },
      },
      highlights = {
        separator = {
          fg = "#434C5E",
        },
        buffer_selected = {
          bold = true,
          italic = false,
        },
        tab_selected = {
          bold = true,
          italic = false,
        },
      },
    }
  end,
}
