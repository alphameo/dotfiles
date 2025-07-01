local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
  local path = filename .. ".ipynb"
  local file = io.open(path, "w")
  if file then
    file:write(default_notebook)
    file:close()
    vim.cmd("edit " .. path)
  else
    print "Error: Could not open new notebook file for writing."
  end
end

vim.api.nvim_create_user_command("NewIPYNB", function(opts)
  new_notebook(opts.args)
end, {
  nargs = 1,
  complete = "file",
})

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
      -- pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip jupytext pandas matplotlib sympy
      -- venv project_name # activate the project venv
      -- pip install ipykernel
      -- python -m ipykernel install --user --name project_name
      -- python3 -m ipykernel install --user
      vim.g.loaded_python3_provider = nil
      vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/nvim/bin/python3"

      local map = vim.keymap.set
      map("n", "<leader>lm", ":MoltenInit<CR>", { silent = true, desc = "Molten Initialize" })
      map("n", "<leader>le", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Molten Operator Selection" })
      map("n", "<leader>ll", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Molten Evaluate Line" })
      map("n", "<leader>lE", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Molten Re-evaluate Cell" })
      map("n", "<leader>ld", ":MoltenDelete<CR>", { silent = true, desc = "Molten Delete Cell" })
      map("n", "<leader>lh", ":MoltenHideOutput<CR>", { silent = true, desc = "Molten Hide Output" })
      map("n", "<leader>ls", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "Molten Show/Enter Output" })
      map("v", "<leader>lE", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "Evaluate visual selection" })
      map("n", "<leader>lM", function()
        local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
        if venv ~= nil then
          -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
          venv = string.match(venv, "/.+/(.+)")
          vim.cmd(("MoltenInit %s"):format(venv))
        else
          vim.cmd "MoltenInit python3"
        end
      end, { desc = "Molten Initialize for python3", silent = true })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = vim.fn.argc(-1) == 0,
    event = { "BufEnter" },
    ft = { "ipynb", "markdown" },
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
    ft = { "quarto", "ipynb", "markdown" },
    config = function()
      require("quarto").setup {
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
      }
      local map = vim.keymap.set
      map("n", "<leader>lq", ":QuartoActivate<CR>", { silent = true, desc = "Quarto Initialize" })
      map("n", "<leader>lP", ":QuartoPreview<CR>", { silent = true, desc = "Quarto Preview" })
      local runner = require "quarto.runner"
      map("n", "<leader>lc", runner.run_cell, { silent = true, desc = "Quarto Run Cell" })
      map("n", "<leader>lu", runner.run_above, { silent = true, desc = "Quarto Run Cell And Upper" })
      map("n", "<leader>la", runner.run_all, { silent = true, desc = "Quarto Run All Cells" })
      map("n", "<leader>lL", runner.run_line, { silent = true, desc = "Quarto Run Line" })
      map("n", "<leader>lA", function()
        runner.run_all(true)
      end, { desc = "Quarto Run All Cells of All Languages", silent = true })
      map("v", "<leader>lr", runner.run_range, { silent = true, desc = "Quarto Run Visual Range" })
    end,
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
