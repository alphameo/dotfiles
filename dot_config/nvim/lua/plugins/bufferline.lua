return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "moll/vim-bbye",
  },
  version = "*",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("bufferline").setup {
      options = {
        numbers = "ordinal",
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        close_command = "Bdelete! %d", -- mouse action exit (press x) command (string or function)
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "none", -- Options: 'icon', 'underline', 'none'
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match "error" and " " or " "
          return " " .. icon .. count
        end,
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
    local map = vim.keymap.set
    map("n", "<A-]>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<C-Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<A-[>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<C-S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<A-.>", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move Tab (buffer) Right" })
    map("n", "<A-,>", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move Tab (buffer) Next" })
    map("n", "<A-g>", ":BufferLinePick<CR>", { silent = true, desc = "Pick Tab (buffer) Next" })
    map("n", "<A-x>", ":BufferLinePickClose<CR>", { silent = true, desc = "Pick buffer to close" })
    map("n", "<A-o>", ":BufferLineCloseOthers<CR>", { silent = true, desc = "Close other buffers" })
    map("n", "<A-\\>", "<C-^>", { silent = true, desc = "Switch to last buffer" })
  end,
}
