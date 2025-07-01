return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.keymap.set("n", "<leader>lp", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown Preview" })
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
    opts = {
      code = {
        width = "block",
        right_pad = 1,
      },
      completions = {
        lsp = { enabled = true },
        blink = { enabled = true },
      },
    },
    config = function()
      vim.cmd "RenderMarkdown disable"
      vim.keymap.set("n", "<leader>lr", ":RenderMarkdown toggle<CR>", { silent = true, desc = "Markdown Render" })
    end,
  },
}
