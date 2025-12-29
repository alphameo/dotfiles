return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.o.showmode = false -- Don't show mode in command line
    vim.o.ruler = false -- Don't show cursor position in command line
    local icon = require("diagnostics").icons

    require("lualine").setup {
      options = {
        icons_enabled = true,
        theme = "onedark",
        --          
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        },
        lualine_c = { { "filename", file_status = true, path = 2 } },
        lualine_x = {
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          { "diagnostics", symbols = { error = icon.Error, warn = icon.Warn, info = icon.Info, hint = icon.Hint } },
          "filetype",
        },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "lazy", "mason", "nvim-dap-ui" },
    }
  end,
}
