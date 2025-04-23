return {
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    ft = "python",
  },
  {
    "benlubas/molten-nvim",
    lazy = true,
    ft = { "python", "markdown", "json" },
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    config = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 999

      -- INFO: VENV
      -- mkdir ~/.virtualenvs
      -- python -m venv ~/.virtualenvs/neovim # create a new venv
      -- # note, activate is a bash/zsh script, use activate.fish for fish shell
      -- source ~/.virtualenvs/neovim/bin/activate # activate the venv
      -- pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip jupytext
      -- venv project_name # activate the project venv
      -- pip install ipykernel
      -- python -m ipykernel install --user --name project_name
      -- python3 -m ipykernel install --user
      vim.g.loaded_python3_provider = nil
      vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/nvim/bin/python3"
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = true,
    event = "VeryLazy",
    ft = { "python", "markdown", "julia", "r", "rust" },
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    ft = { "quarto", "markdown", "json", "python" },
    dev = false,
    opts = {
      lspFeatures = {
        languages = { "python" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = { enabled = true },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    ft = { "quarto", "markdown", "python", "r", "julia" },
    opts = {},
  },
}
