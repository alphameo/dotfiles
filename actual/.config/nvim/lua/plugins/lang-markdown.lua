return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    -- INFO: install with yarn/npm
    build = "cd app && npm install",
    -- or
    -- build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    -- INFO: install without yarn/npm
    -- build = function()
    --   vim.fn["mkdp#util#install"]()
    -- end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set(
            "n",
            "<leader>lp",
            ":MarkdownPreviewToggle<CR>",
            { buffer = true, silent = true, desc = "Markdown Preview" }
          )
        end,
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    ft = { "markdown", "norg", "rmd", "org" },
    config = function()
      require("render-markdown").setup {
        code = {
          width = "block",
          right_pad = 1,
        },
        completions = {
          lsp = { enabled = true },
          blink = { enabled = true },
        },
      }
      vim.cmd "RenderMarkdown disable"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set(
            "n",
            "<leader>lr",
            ":RenderMarkdown toggle<CR>",
            { buffer = true, silent = true, desc = "Markdown Render" }
          )
        end,
      })
    end,
  },
}
