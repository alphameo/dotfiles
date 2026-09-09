local setup_surround = function()
  require("mini.surround").setup {
    custom_surroundings = nil,
    highlight_duration = 500,
    mappings = {
      add = "ys", -- Add surrounding in Normal and Visual modes
      delete = "ds", -- Delete surrounding
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "", -- Highlight surrounding
      replace = "cs", -- Replace surrounding

      suffix_last = "", -- Suffix to search with "prev" method
      suffix_next = "", -- Suffix to search with "next" method
    },
    n_lines = 20,
    respect_selection_type = false,
    search_method = "cover",
    silent = true,
  }
end

local setup_trailspace = function()
  local trailspace = require "mini.trailspace"
  trailspace.setup()
  vim.keymap.set("n", "grs", function()
    trailspace.trim()
    trailspace.trim_last_lines()
  end, { desc = "Refactor trim Trailspaces" })
end

local setup_jump2d = function()
  local jump = require "mini.jump2d"
  jump.setup {
    mappings = {
      start_jumping = "gw",
    },
  }
end

local setup_sessions = function()
  local sessions = require "mini.sessions"
  sessions.setup()
  vim.keymap.set("n", "<leader>po", function()
    sessions.select "read"
  end, { desc = "Project Open" })
  vim.keymap.set("n", "<leader>pr", function()
    sessions.select "write"
  end, { desc = "Project Replace" })
  vim.keymap.set("n", "<leader>pd", function()
    sessions.select "delete"
  end, { desc = "Project Delete" })
  vim.keymap.set("n", "<leader>ps", function()
    vim.ui.input({ prompt = "Project name: " }, function(input)
      if input and input ~= "" then
        sessions.write(input)
      end
    end)
  end, { desc = "Project Save" })
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
  vim.api.nvim_create_autocmd("FileType", {
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
  sj.setup {
    mappings = {
      toggle = "",
      split = "",
      join = "",
    },
    detect = {
      -- Default: { '%b()', '%b[]', '%b{}' }
      brackets = nil,
      separator = ",",
      -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
      exclude_regions = nil,
    },
    split = {
      hooks_pre = {},
      hooks_post = {},
    },
    join = {
      hooks_pre = {},
      hooks_post = {},
    },
  }
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
end

local setup_bufremove = function()
  local bufremove = require "mini.bufremove"
  bufremove.setup()
  vim.keymap.set("n", "<M-w>", function()
    bufremove.delete(0, false)
  end, { desc = "Close buffer" })
end

local setup_statusline = function()
  vim.o.laststatus = 3
  local stl = require "mini.statusline"

  local sep = "︙"

  local icon = require("diagnostics").icons
  local signs = { ERROR = icon.Error, WARN = icon.Warn, INFO = icon.Info, HINT = icon.Hint }

  local get_location = function()
    return "%2l:%-2v"
  end

  vim.api.nvim_create_autocmd("RecordingEnter", {
    pattern = "*",
    callback = function()
      vim.cmd "redrawstatus"
    end,
  })
  vim.api.nvim_create_autocmd("RecordingLeave", {
    pattern = "*",
    callback = function()
      vim.cmd "redrawstatus"
    end,
  })

  local get_recording_macro_prefix = function()
    if vim.fn.reg_recording() ~= "" then
      return "@" .. vim.fn.reg_recording() .. ": "
    else
      return ""
    end
  end

  local get_keystroke = function()
    return require("custom.key_history").last or ""
  end

  local get_file_percentage = function()
    local line = vim.fn.line "."
    local total = vim.fn.line "$"
    local percent = math.floor(line / total * 100)
    return string.format("%d%%%%", percent)
  end

  -- local lsp_status = vim.ui.progress_status

  stl.setup {
    use_icons = vim.g.have_nerd_font,
    set_vim_settings = true,
    content = {
      active = function()
        local mode, mode_hl = stl.section_mode { trunc_width = 120 }
        local git = stl.section_git { trunc_width = 40 }
        local diff = stl.section_diff { trunc_width = 75 }
        local diagnostics = stl.section_diagnostics {
          trunc_width = 75,
          icon = "",
          signs = signs,
        }
        -- local lsp = stl.section_lsp { trunc_width = 75 }
        local filename = stl.section_filename { trunc_width = 140 }
        local fileinfo = stl.section_fileinfo { trunc_width = 9999 }
        local location = get_location()
        local search = stl.section_searchcount { trunc_width = 75 }
        if #search > 0 then
          search = " " .. search .. " " .. sep
        end

        local key_cmd = get_recording_macro_prefix() .. get_keystroke()
        local percentage = get_file_percentage()

        return stl.combine_groups {
          { hl = mode_hl, strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diff } },
          "%<", -- general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- end left alignment
          { hl = "MiniStatuslineFilename", strings = {} },
          { hl = "MiniStatuslineFilename", strings = { search, key_cmd, diagnostics } },
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

local setup_notify = function()
  local notify = require "mini.notify"
  notify.setup {
    lsp_progress = {
      enable = true,
      level = "INFO",
      duration_last = 1000,
    },

    window = {
      -- Floating window config
      config = {},

      max_width_share = 0.382,

      winblend = 25,
    },
  }

  vim.keymap.set("n", "<leader>nn", notify.show_history, { desc = "Notifications List" })
end

local setup_completion = function()
  vim.o.completeopt = "menuone,noinsert,fuzzy"
  vim.o.complete = ".,w,b,u"
  local completion = require "mini.completion"
  completion.setup {
    mappings = {
      force_twostep = "<C-Space>",
      force_fallback = "<A-Space>",
      scroll_down = "<C-e>",
      scroll_up = "<C-y>",
    },
  }
end

local setup_cmdline_cmp = function()
  vim.o.wildmenu = true
  vim.o.wildmode = "noselect,full"
  vim.o.wildoptions = "pum,fuzzy"
  local cmdline = require "mini.cmdline"
  cmdline.setup {
    autocorrect = { enable = false },
    autopeek = { enable = false },
  }
end

local setup_snippets = function()
  local snippets = require "mini.snippets"
  local gen_loader = require("mini.snippets").gen_loader
  snippets.setup {
    snippets = {
      -- gen_loader.from_file "~/.config/nvim/snippets/global.json",
      gen_loader.from_lang(),
      snippets.gen_loader.from_runtime "snippets",
    },

    mappings = {
      expand = "",

      jump_next = "<M-n>",
      jump_prev = "<M-p>",
      stop = "<C-c>",
    },
  }
  require("mini.snippets").start_lsp_server()
end

local setup_icons = function()
  local icons = require "mini.icons"
  icons.setup {
    style = "glyph", -- "glyph" | "ascii"
  }
end

local setup_pickers = function()
  local pick = require "mini.pick"
  local extra = require "mini.extra"
  pick.setup()
  extra.setup()

  local map = vim.keymap.set
  map("n", "grR", function()
    extra.pickers.lsp { scope = "references" }
  end, { desc = "Find all locations" })

  map("n", "<leader>ff", pick.builtin.files, { desc = "Find Files" })
  map("n", "<leader>fg", pick.builtin.grep_live, { desc = "Find by Grep" })
  map("n", "<leader>fw", function()
    extra.pickers.grep { pattern = vim.fn.expand "<cword>" }
  end, { desc = "Find Words" })
  map("n", "<leader>fr", extra.pickers.oldfiles, { desc = "Find Recent Files" })

  map("n", "<leader>fm", extra.pickers.marks, { desc = "Find Marks" })
  map("n", "<leader>fb", pick.builtin.buffers, { desc = "Find Buffers" })
  map("n", "<leader>fj", function()
    extra.pickers.list { scope = "jump" }
  end, { desc = "Find in Jump List" })
  map("n", "<leader>fq", function()
    extra.pickers.list { scope = "quickfix" }
  end, { silent = true, desc = "Find in Quickfix List" })
  map("n", "<leader>fd", function()
    extra.pickers.diagnostic { scope = "current" }
  end, { silent = true, desc = "Find in document Diagnostics" })
  map("n", "<leader>fD", function()
    extra.pickers.diagnostic { scope = "all" }
  end, { silent = true, desc = "Find in workspace Diagnostics" })

  map("n", "<leader>fh", extra.pickers.git_hunks, { desc = "Find Git Hunks" })

  map("n", "<leader>.K", extra.pickers.keymaps, { desc = "Inspect Keymapping" })
end

-- TODO: check mappings, when removing plugin
return {
  "echasnovski/mini.nvim",
  dependencies = {
    -- "rafamadriz/friendly-snippets",
  },
  version = false,
  lazy = true,
  event = "VeryLazy",
  config = function()
    -- require("mini.pairs").setup()
    -- setup_surround()
    -- require("mini.move").setup()
    -- setup_sessions()
    -- setup_bracketed()
    -- setup_indentscope()
    -- setup_sj()
    setup_tabline()
    setup_statusline()
    setup_notify()
    setup_trailspace()
    -- setup_jump2d()
    -- setup_snippets()
    -- setup_completion()
    -- setup_cmdline_cmp()
    -- setup_icons()
    -- setup_pickers()
    setup_bufremove()
  end,
}
