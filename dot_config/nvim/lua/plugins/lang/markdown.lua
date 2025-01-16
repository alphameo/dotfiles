return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "marksman", "prettierd", "markdownlint-cli2", "markdown-toc" } },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").marksman.setup {
        on_attach = require("configs.lspconfig").on_attach,
        capabilities = require("configs.lspconfig").capabilities,
      }
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load { plugins = { "markdown-preview.nvim" } }
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd [[do FileType]]
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.keymap.set("n", "<leader>cr", require("render-markdown").toggle, { desc = "Markdown Render" })
    end,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   config = function(_, opts)
  --     local nls = require "null-ls"
  --     nls.setup {
  --       sources = vim.list_extend(opts.sources or {}, {
  --         nls.builtins.formatting.prettierd.with {
  --           filetypes = {
  --             "markdown",
  --           },
  --         },
  --         nls.builtins.diagnostics.markdownlint_cli2,
  --       }),
  --     }
  --   end,
  -- },
}
