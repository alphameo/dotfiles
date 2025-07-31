return {
  "echasnovski/mini.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "moll/vim-bbye",
  },
  version = false,
  lazy = true,
  event = "VeryLazy",
  config = function()
    local map = vim.keymap.set
    require("mini.pairs").setup()

    require("mini.ai").setup { n_lines = 500 }

    require("mini.surround").setup()

    require("mini.move").setup()

    -- -- require("mini.bracketed").setup()

    local sessions = require "mini.sessions"
    sessions.setup()
    map("n", "<leader>wo", function()
      sessions.select "read"
    end, { desc = "Workspaces Open" })
    map("n", "<leader>wr", function()
      sessions.select "write"
    end, { desc = "Workspaces Replace" })
    map("n", "<leader>wd", function()
      sessions.select "delete"
    end, { desc = "Workspaces Delete" })
    vim.keymap.set("n", "<leader>ws", function()
      vim.ui.input({ prompt = "Workspace name: " }, function(input)
        if input and input ~= "" then
          sessions.write(input)
        end
      end)
    end, { desc = "Workspaces Save" })

    local indent = require "mini.indentscope"
    indent.setup {
      draw = {
        delay = 0,
        animation = indent.gen_animation.none(),
      },
      symbol = "▎",
    }

    local sj = require "mini.splitjoin"
    sj.setup()
    map("n", "<leader>cj", sj.toggle, { desc = "Code SplitJoin" })

    vim.api.nvim_set_hl(0, "MiniTablineVisible", {
      fg = "#777777",
      bg = "#1e1e1e",
    })

    local tabline = require "mini.tabline"
    local function get_diagnostic_symbol(bufnr)
      local levels = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
      }

      local diagnostics = vim.diagnostic.get(bufnr)
      local counts = {}

      for _, d in ipairs(diagnostics) do
        local severity = d.severity
        counts[severity] = (counts[severity] or 0) + 1
      end
      local diagn = ""
      for _, severity in ipairs {
        vim.diagnostic.severity.ERROR,
        vim.diagnostic.severity.WARN,
      } do
        if counts[severity] then
          diagn = diagn .. levels[severity] .. counts[severity] .. " "
        end
      end

      return diagn
    end
    -- local prefix = "▎"
    local prefix = ""
    tabline.setup {
      format = function(buf_id, label)
        local suffix = vim.bo[buf_id].modified and " " or ""
        return prefix .. tabline.default_format(buf_id, label) .. get_diagnostic_symbol(buf_id) .. suffix
      end,
    }
    map("n", "<A-]>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
    map("n", "<A-[>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<C-S-Tab>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
    map("n", "<A-g>", ":Telescope buffers<CR>", { silent = true, desc = "Pick Tab (buffer) Next" })
    map("n", "<A-w>", ":Bdelete<CR>", { silent = true, desc = "Pick buffer to close" })
    map("n", "<A-\\>", "<C-^>", { silent = true, desc = "Switch to last buffer" })

    local stl = require "mini.statusline"
    stl.section_location = function()
      return "%2l:%-2v"
    end
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
          -- local lsp = stl.section_lsp { trunc_width = 75 }
          local filename = stl.section_filename { trunc_width = 140 }
          local fileinfo = stl.section_fileinfo { trunc_width = 9999 }
          local location = stl.section_location { trunc_width = 75 }
          local search = stl.section_searchcount { trunc_width = 75 }

          local noice_cmd = ""
          if pcall(require, "noice") and require("noice").api.status.command.has() then
            noice_cmd = require("noice").api.status.command.get()
          end
          return stl.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
            "%<", -- general truncate point
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=", -- end left alignment
            { hl = "MiniStatuslineFilename", strings = { noice_cmd } },
            { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = mode_hl, strings = { search, location } },
          }
        end,
      },
    }
  end,
}
