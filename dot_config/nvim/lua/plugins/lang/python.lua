return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true

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
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown",
    },
  },
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown", "python" },
    dev = false,
    dependencies = {
      "jmbuhr/otter.nvim",
    },
    config = function()
      local quarto = require "quarto"

      quarto.setup {
        codeRunner = {
          default_method = "molten",
        },
      }

      vim.keymap.set("n", "<leader>ji", ":QuartoActivate<CR>", { silent = true, desc = "Quatro Initialize" })
      vim.keymap.set("n", "<leader>jp", quarto.quartoPreview, { silent = true, desc = "Quatro Preview" })
      local runner = require "quarto.runner"
      vim.keymap.set("n", "<leader>jc", runner.run_cell, { silent = true, desc = "Run Cell" })
      vim.keymap.set("n", "<leader>ju", runner.run_above, { silent = true, desc = "Run Cell And Upper" })
      vim.keymap.set("n", "<leader>ja", runner.run_all, { silent = true, desc = "Run All Cells" })
      vim.keymap.set("n", "<leader>jl", runner.run_line, { silent = true, desc = "Run Line" })
      vim.keymap.set("v", "<leader>j", runner.run_range, { silent = true, desc = "Run Visual Range" })
      vim.keymap.set("n", "<leader>jA", function()
        runner.run_all(true)
      end, { desc = "Run All Cells of All Languages", silent = true })
    end,
  },
}
