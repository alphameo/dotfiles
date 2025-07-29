return {
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
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
    end,
  },
}
