return {
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    ft = "python",
    config = function()
      require("dap-python").setup(vim.env.HOME .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
      require("dap-python").default_port = 38000
    end,
  },
}
