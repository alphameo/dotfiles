-- INFO: Jupyter Notebook
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

-- NOTE: TERMINALS
local terminal_state = {
  floating = {
    buf = -1,
    win = -1,
  },
  split = {
    buf = -1,
    win = -1,
  },
}

-- NOTE: Split Terminal
local create_split_buffer = function(opts)
  opts = opts or {}

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    vertical = false,
    split = "below",
    height = 15,
    style = "minimal",
  }
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end
local toggle_split_terminal = function()
  if not vim.api.nvim_win_is_valid(terminal_state.floating.win) then
    terminal_state.floating = create_split_buffer { buf = terminal_state.floating.buf }
    if vim.bo[terminal_state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(terminal_state.floating.win)
  end
  -- vim.cmd.vnew()
  -- vim.cmd.term()
  -- vim.cmd.wincmd "J"
  -- vim.api.nvim_win_set_height(0, 15)
  -- vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("ToggleSplitTerm", toggle_split_terminal, {})

-- NOTE: Float Terminal
local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_float_terminal = function()
  if not vim.api.nvim_win_is_valid(terminal_state.floating.win) then
    terminal_state.floating = create_floating_window { buf = terminal_state.floating.buf }
    if vim.bo[terminal_state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(terminal_state.floating.win)
  end
end

vim.api.nvim_create_user_command("ToggleFloatTerm", toggle_float_terminal, {})
