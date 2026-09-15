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

local function molten_autoinit()
  local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
  if venv ~= nil then
    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd "MoltenInit python3"
  end
end

local function new_notebook(filename)
  local path = filename .. ".ipynb"
  local file = io.open(path, "w")
  if file then
    file:write(default_notebook)
    file:close()
  else
    print "Error: Could not open new notebook file for writing."
  end
end

local function ipy_help()
  local help_msg = [[
# Setup neovim venv

1. `mkdir ~/.virtualenvs`
2. `python -m venv ~/.virtualenvs/nvim` # create a new venv
3. `source ~/.virtualenvs/nvim/bin/activate` # activate the venv (for bash/zsh -- "activate", for fish -- "activate.fish")
4.1 `pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip` # install python modules for molten-plugin
4.2 `pip install jupytext` # install python modules for jupytext integration


# Setup project venv

1. `source .venv/bin/activate` # activate the venv (for bash/zsh -- "activate", for fish -- "activate.fish")
2. install ipykernel as dependency into venv
3. `python -m ipykernel install --user --name <project_name>` # registrer ipykernel from venv
*. installed kernel are located at `~/.local/share/jupyter/kernels/`


# Plots in matplotlib

to show plots edit `~/.local/share/jupyter/kernels/<project_name>/kernel.json`:
  add flag `"--matplotlib=inline"`


# Converts

1. Install jupyter's nbconvert module

html: `jupyter nbconvert --to html <name.ipynb>`
pdf (required: pandoc, latex): `jupyter nbconvert --to pdf <name.ipynb>`
    ]]

  require("custom.info").show(help_msg, { ft = "lint-info" })
end

vim.api.nvim_create_user_command("NewIPYNB", function(opts)
  new_notebook(opts.args)
end, {
  nargs = 1,
  complete = "file",
  desc = "Create .ipynb file",
})

vim.api.nvim_create_user_command("IPYHelp", function()
  ipy_help()
end, {
  desc = "ipy help",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_create_user_command("NotebookInit", function()
      vim.cmd "QuartoActivate"
      vim.cmd "MoltenInit"
    end, {
      desc = "Init Notebook suite",
    })

    vim.api.nvim_create_user_command("MoltenAutoInit", function()
      molten_autoinit()
    end, {
      desc = "Init Notebook suite",
    })
  end,
})

return {
  {
    "benlubas/molten-nvim",
    lazy = true,
    ft = { "python", "markdown", "json" },
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    config = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 999

      vim.g.loaded_python3_provider = nil
      vim.g.python3_host_prog = vim.fn.expand "~/.virtualenvs/nvim/bin/python3"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local map = vim.keymap.set
          local opts = function(desc)
            return { buffer = true, silent = true, desc = desc }
          end
          -- map("n", "<leader>lm", ":MoltenInit<CR>", opts "Molten Initialize")
          map("n", "<leader>lr", ":MoltenRestart<CR>", opts "Molten Restart")
          map("n", "<leader>lR", ":MoltenRestart!<CR>", opts "Molten Restart & Delete Cells")
          -- map("n", "<leader>lO", ":MoltenEvaluateOperator<CR>", opts "Molten Operator Selection")
          -- map("n", "<leader>ll", ":MoltenEvaluateLine<CR>", opts "Molten Evaluate Line")
          map("n", "<leader>lE", ":MoltenReevaluateCell<CR>", opts "Molten Re-evaluate Cell")
          map("v", "<leader>le", ":<C-u>MoltenEvaluateVisual<CR>gv", opts "Evaluate Visual Selection")
          map("n", "<leader>li", ":MoltenInterrupt<CR>", opts "Molten Interrupt Kernel")

          map("n", "<leader>ld", ":MoltenDelete<CR>", opts "Molten Delete Cell")
          -- map("n", "<leader>ls", ":MoltenSave<CR>", opts "Molten Save")
          map("n", "<leader>lE", ":MoltenExportOutput<CR>", opts "Molten Export Output")
          map("n", "<leader>ly", ":MoltenYankOutput<CR>", opts "Molten Export Output")

          -- map("n", "<leader>lh", ":MoltenHideOutput<CR>", opts "Molten Hide Output")
          map("n", "<leader>lo", ":noautocmd MoltenEnterOutput<CR>", opts "Molten Show/Enter Output")
          map("n", "<leader>li", ":MoltenImagePopup<CR>", opts "Molten Open Output Image")
        end,
      })
    end,
  },
  {
    -- Needs executable `jupytext` (install via pipx or get from aur)
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
      local map = vim.keymap.set
      map("n", "<leader>lf", ":noautocmd edit<CR>", { silent = true, desc = "Jupytext Original File" })
      map("n", "<leader>lF", ":edit<CR>", { silent = true, desc = "Jupytext Converted File" })
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
    cmd = "QuartoActivate",
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

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- local quarto = require "quarto"
          local qrunner = require "quarto.runner"
          local map = vim.keymap.set
          -- map("n", "<leader>lq", ":QuartoActivate<CR>", { buffer = true, silent = true, desc = "Quarto Initialize" })
          -- map("n", "<leader>lP", quarto.quartoPreview, { buffer = true, silent = true, desc = "Quarto Preview" })
          map("n", "<leader>lc", qrunner.run_cell, { buffer = true, desc = "Quarto Run Cell" })
          map("n", "<leader>lu", qrunner.run_above, { buffer = true, desc = "Quarto Run Cell Above" })
          map("n", "<leader>lb", qrunner.run_below, { buffer = true, desc = "Quarto Run Cell Below" })
          map("n", "<leader>la", qrunner.run_all, { buffer = true, desc = "Quarto Run All Cells" })
          -- map("n", "<leader>ll", qrunner.run_line, { buffer = true, desc = "Quarto Run Line" })
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
    ft = { "quarto", "ipynb", "markdown" },
    config = function()
      require("otter").setup()
    end,
  },
}
