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
    local icons = require("diagnostics").icons
    require("bufferline").setup {
      options = {
        -- numbers = "ordinal",
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        close_command = "Bdelete! %d", -- mouse action exit (press x) command (string or function)
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "none", -- Options: 'icon', 'underline', 'none'
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
          local icon = level:match "error" and icons.Error or icons.Warn
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
    map("n", "<M-]>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<M-[>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<M-0>", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move Tab (buffer) Right" })
    map("n", "<M-9>", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move Tab (buffer) Next" })
    map("n", "<M-g>", ":BufferLinePick<CR>", { silent = true, desc = "Pick Tab (buffer) Next" })
    map("n", "<M-w>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" })
    map("n", "<M-x>", ":BufferLinePickClose<CR>", { silent = true, desc = "Pick buffer to close" })
    map("n", "<M-o>", ":BufferLineCloseOthers<CR>", { silent = true, desc = "Close other buffers" })

    map("n", "]b", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "[b", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<C-n>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<C-p>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<C-Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<C-S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<C-0>", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move Tab (buffer) Right" })
    map("n", "<C-9>", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move Tab (buffer) Next" })
    map("n", "<C-x>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" })
  end,
}
