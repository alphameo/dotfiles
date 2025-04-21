return {
  "nvim-lualine/lualine.nvim",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
      end,
    }

    local filename = {
      "filename",
      file_status = true,
      path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
      update_in_insert = true,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " },
      cond = hide_in_width,
    }

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
        lualine_a = { mode },
        lualine_b = { "branch" },
        lualine_c = { filename },
        lualine_x = {
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          diagnostics,
          diff,
          { "encoding", cond = hide_in_width },
          { "filetype", cond = hide_in_width },
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
      extensions = { "fugitive" },
    }
  end,
}
