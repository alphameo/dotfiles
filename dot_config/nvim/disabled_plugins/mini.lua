return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("mini.pairs").setup()

    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require("mini.ai").setup { n_lines = 500 }

    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require("mini.surround").setup()

    -- - gS    - [g]Toggle []S]plitjoin
    require("mini.splitjoin").setup()

    local stl = require "mini.statusline"

    stl.setup {
      use_icons = true,
      set_vim_settings = false, -- You already set vim.o.showmode = false
      content = {
        active = function()
          local mode, mode_hl = stl.section_mode { trunc_width = 120 }
          local git = stl.section_git { trunc_width = 40 }
          local diff = stl.section_diff { trunc_width = 75 }
          local diagnostics = stl.section_diagnostics {
            trunc_width = 75,
            icon = "",
            signs = { ERROR = " ", WARN = " ", INFO = " ", HINT = "󰌵 " },
          }
          local lsp = stl.section_lsp { trunc_width = 75 }
          local filename = stl.section_filename { trunc_width = 140 }
          local fileinfo = stl.section_fileinfo { trunc_width = 120 }
          local location = stl.section_location { trunc_width = 75 }
          local search = stl.section_searchcount { trunc_width = 75 }

          local noice_cmd = ""
          if pcall(require, "noice") and require("noice").api.status.command.has() then
            noice_cmd = require("noice").api.status.command.get()
          end
          --   local sep_section = "  "
          local sep_component = ""
          return stl.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
            "%<", -- general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- end left alignment
            {
              hl = "MiniStatuslineFileinfo",
              strings = { noice_cmd, sep_component, diagnostics, sep_component, fileinfo },
            },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
      },
    }
    stl.section_location = function()
      return "%2l:%-2v"
    end
  end,
}
