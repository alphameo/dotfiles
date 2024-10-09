return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ""
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_page_title = "${name}.md"
      vim.g.mkdp_preview_options = {
        disable_sync_scroll = 0,
        disable_filename = 1,
      }
    end,
    config = function()
      vim.keymap.set("n", "<leader>lp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Lang: Markdown Preview" })
    end,
  },
  -- {
  --   "wallpants/github-preview.nvim",
  --   cmd = { "GithubPreviewToggle" },
  --   keys = { "<leader>lt" },
  --   opts = {
  --     host = "localhost",
  --     port = 6041,
  --     -- set to "true" to force single-file mode & disable repository mode
  --     single_file = false,
  --     theme = {
  --       -- "system" | "light" | "dark"
  --       name = "system",
  --       high_contrast = false,
  --     },
  --     -- define how to render <details> tags on init/content-change
  --     -- true: <details> tags are rendered open
  --     -- false: <details> tags are rendered closed
  --     details_tags_open = true,
  --     cursor_line = {
  --       disable = false,
  --       -- CSS color
  --       -- if you provide an invalid value, cursorline will be invisible
  --       color = "#c86414",
  --       opacity = 0.2,
  --     },
  --     scroll = {
  --       disable = false,
  --       -- Between 0 and 100
  --       -- VERY LOW and VERY HIGH numbers might result in cursorline out of screen
  --       top_offset_pct = 35,
  --     },
  --     -- for debugging
  --     -- nil | "debug" | "verbose"
  --     log_level = nil,
  --   },
  --   config = function(_, opts)
  --     local gpreview = require "github-preview"
  --     gpreview.setup(opts)
  --
  --     local fns = gpreview.fns
  --     vim.keymap.set("n", "<leader>lt", fns.toggle, { desc = "Lang: Markdown Preview" })
  --     vim.keymap.set("n", "<leader>ls", fns.single_file_toggle)
  --     vim.keymap.set("n", "<leader>lP", fns.details_tags_toggle)
  --   end,
  -- },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ft = "markdown",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      local rndr = require "render-markdown"
      vim.keymap.set("n", "<leader>lr", rndr.toggle, { desc = "Lang: Markdown Render" })
    end,
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   -- lazy = false, -- Recommended
  --   ft = "markdown", -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
}
