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
      -- [Setup neovim venv]
      -- mkdir ~/.virtualenvs
      -- python -m venv ~/.virtualenvs/neovim # create a new venv
      -- # activate the venv: note, activate is a bash/zsh script, use activate.fish for fish shell
      -- source ~/.virtualenvs/neovim/bin/activate # activate the venv
      -- pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip jupytext pandas matplotlib sympy
      -- [Setup project venv]
      -- venv project_name # activate the project venv
      -- pip install ipykernel
      -- python -m ipykernel install --user --name project_name
      -- python3 -m ipykernel install --user
      vim.g.loaded_python3_provider = nil
      vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/nvim/bin/python3"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>lm", ":MoltenInit<CR>", { buffer = true, silent = true, desc = "Molten Initialize" })
          map(
            "n",
            "<leader>le",
            ":MoltenEvaluateOperator<CR>",
            { buffer = true, silent = true, desc = "Molten Operator Selection" }
          )
          map(
            "n",
            "<leader>ll",
            ":MoltenEvaluateLine<CR>",
            { buffer = true, silent = true, desc = "Molten Evaluate Line" }
          )
          map(
            "n",
            "<leader>lE",
            ":MoltenReevaluateCell<CR>",
            { buffer = true, silent = true, desc = "Molten Re-evaluate Cell" }
          )
          map("n", "<leader>ld", ":MoltenDelete<CR>", { buffer = true, silent = true, desc = "Molten Delete Cell" })
          map("n", "<leader>lh", ":MoltenHideOutput<CR>", { buffer = true, silent = true, desc = "Molten Hide Output" })
          map(
            "n",
            "<leader>ls",
            ":noautocmd MoltenEnterOutput<CR>",
            { buffer = true, silent = true, desc = "Molten Show/Enter Output" }
          )
          map(
            "v",
            "<leader>lE",
            ":<C-u>MoltenEvaluateVisual<CR>gv",
            { buffer = true, silent = true, desc = "Evaluate visual selection" }
          )
          map("n", "<leader>lM", function()
            local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
            if venv ~= nil then
              -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
              venv = string.match(venv, "/.+/(.+)")
              vim.cmd(("MoltenInit %s"):format(venv))
            else
              vim.cmd "MoltenInit python3"
            end
          end, { buffer = true, silent = true, desc = "Molten Initialize for python3" })
        end,
      })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    lazy = vim.fn.argc(-1) == 0,
    event = { "BufEnter" },
    ft = { "ipynb", "markdown" },
    config = function()
      require("jupytext").setup {
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      }
    end,
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

      local qrunner = require "quarto.runner"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local map = vim.keymap.set
          map("n", "<leader>lq", ":QuartoActivate<CR>", { buffer = true, silent = true, desc = "Quarto Initialize" })
          map("n", "<leader>lP", ":QuartoPreview<CR>", { buffer = true, silent = true, desc = "Quarto Preview" })
          map("n", "<leader>lc", qrunner.run_cell, { buffer = true, desc = "Quarto Run Cell" })
          map("n", "<leader>lu", qrunner.run_above, { buffer = true, desc = "Quarto Run Cell Above" })
          map("n", "<leader>la", qrunner.run_all, { buffer = true, desc = "Quarto Run All Cells" })
          map("n", "<leader>lL", qrunner.run_line, { buffer = true, desc = "Quarto Run Line" })
          map("n", "<leader>lA", function()
            qrunner.run_all(true)
          end, { buffer = true, silent = true, desc = "Quarto Run All Cells of All Languages" })
          map("v", "<leader>lr", qrunner.run_range, { buffer = true, silent = true, desc = "Quarto Run Visual Range" })
        end,
      })
    end,
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    ft = { "quarto", "markdown", "python", "r", "julia" },
    config = function()
      require("otter").setup()
    end,
  },
}
