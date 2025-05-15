return {
  {
    "olexsmir/gopher.nvim",
    lazy = true,
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    ft = "go",
    opts = {},
  },
}
