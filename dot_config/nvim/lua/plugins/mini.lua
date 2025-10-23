vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "neo-tree" },
  callback = function(args)
    vim.b[args.buf].ministatusline_disable = true
  end,
})
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    vim.b[args.buf].miniindentscope_disable = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "startify",
    "alpha",
    "ministarter",
    "dashboard",
    "neo-tree",
    "NvimTree",
    "Trouble",
    "lazy",
    "packer",
    "mason",
    "toggleterm",
    "neogitstatus",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

local setup_sessions = function()
  local sessions = require "mini.sessions"
  sessions.setup()
  vim.keymap.set("n", "<leader>wo", function()
    sessions.select "read"
  end, { desc = "Workspaces Open" })
  vim.keymap.set("n", "<leader>wr", function()
    sessions.select "write"
  end, { desc = "Workspaces Replace" })
  vim.keymap.set("n", "<leader>wd", function()
    sessions.select "delete"
  end, { desc = "Workspaces Delete" })
  vim.keymap.set("n", "<leader>ws", function()
    vim.ui.input({ prompt = "Workspace name: " }, function(input)
      if input and input ~= "" then
        sessions.write(input)
      end
    end)
  end, { desc = "Workspaces Save" })
end

local setup_bracketed = function()
  require("mini.bracketed").setup {
    buffer = { suffix = "b", options = {} },
    comment = { suffix = "c", options = {} },
    conflict = { suffix = "x", options = {} },
    diagnostic = { suffix = "" }, -- exists in diagnostics
    file = { suffix = "f", options = {} },
    indent = { suffix = "i", options = {} },
    jump = { suffix = "" }, -- exists in mappings
    location = { suffix = "l", options = {} },
    oldfile = { suffix = "o", options = {} },
    quickfix = { suffix = "q", options = {} },
    treesitter = { suffix = "t", options = {} },
    undo = { suffix = "u", options = {} },
    window = { suffix = "w", options = {} },
    yank = { suffix = "y", options = {} },
  }
end

local setup_indentscope = function()
  local indent = require "mini.indentscope"
  indent.setup {
    draw = {
      delay = 0,
      animation = indent.gen_animation.none(),
    },
    symbol = "▎",
  }
end

local setup_sj = function()
  local sj = require "mini.splitjoin"
  sj.setup()
  vim.keymap.set("n", "grj", sj.toggle, { desc = "Refactor SplitJoin" })
end

local setup_tabline = function()
  local tabline = require "mini.tabline"
  local icon = require("diagnostics").icons
  local function get_diagnostic_symbol(bufnr)
    local levels = {
      [vim.diagnostic.severity.ERROR] = icon.Error,
      [vim.diagnostic.severity.WARN] = icon.Warn,
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
  vim.keymap.set("n", "<M-g>", ":Telescope buffers<CR>", { silent = true, desc = "Pick Tab (buffer) Next" })
  vim.keymap.set("n", "<M-w>", ":Bdelete<CR>", { silent = true, desc = "Pick buffer to close" })
  vim.keymap.set("n", "<C-x>", ":Bdelete<CR>", { silent = true, desc = "Pick buffer to close" })
end

local setup_statusline = function()
  vim.api.nvim_set_hl(0, "MiniStatuslineFilename", {
    fg = "#abb2bf",
    bg = "#31353f",
  })
  local stl = require "mini.statusline"
  stl.section_location = function()
    return "%2l:%-2v"
  end
  local icon = require("diagnostics").icons
  stl.setup {
    use_icons = true,
    set_vim_settings = false, -- You already set vim.o.showmode = false
    content = {
      active = function()
        local sep = "︙"
        local mode, mode_hl = stl.section_mode { trunc_width = 120 }
        local git = stl.section_git { trunc_width = 40 }
        local diff = stl.section_diff { trunc_width = 75 }
        local diagnostics = stl.section_diagnostics {
          trunc_width = 75,
          icon = "",
          signs = { ERROR = icon.Error, WARN = icon.Warn, INFO = icon.Info, HINT = icon.Hint },
        }
        -- local lsp = stl.section_lsp { trunc_width = 75 }
        local filename = stl.section_filename { trunc_width = 140 }
        local fileinfo = stl.section_fileinfo { trunc_width = 9999 }
        local location = stl.section_location { trunc_width = 75 }
        -- local search = stl.section_searchcount { trunc_width = 75 }

        local noice_cmd = ""
        if pcall(require, "noice") and require("noice").api.status.command.has() then
          noice_cmd = require("noice").api.status.command.get()
        end

        local line = vim.fn.line "."
        local total = vim.fn.line "$"
        local percent = math.floor(line / total * 100)

        local percentage = string.format("%d%%%%", percent)

        return stl.combine_groups {
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
          "%<", -- general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- end left alignment
          { hl = "MiniStatuslineFilename", strings = {} },
          { hl = "MiniStatuslineFilename", strings = { noice_cmd, sep, diagnostics } },
          { hl = "MiniStatuslineFilename", strings = { fileinfo } },
          { hl = "MiniStatuslineFileinfo", strings = { location } },
          { hl = mode_hl, strings = { percentage } },
        }
      end,
      inactive = function()
        local filename = stl.section_filename { trunc_width = 140 }
        local fileinfo = stl.section_fileinfo { trunc_width = 9999 }

        return stl.combine_groups {
          "%<", -- general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- end left alignment
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        }
      end,
    },
  }
end

-- TODO: check mappings, when removing plugin
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
    -- require("mini.pairs").setup()
    require("mini.surround").setup()
    -- require("mini.move").setup()
    setup_sessions()
    -- setup_bracketed()
    setup_indentscope()
    setup_sj()
    -- setup_tabline()
    setup_statusline()
  end,
}
