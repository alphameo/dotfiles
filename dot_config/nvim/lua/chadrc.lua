-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
}

M.ui = {
  cmp = {
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },

  telescope = {
    style = "borderless",  -- borderless / bordered
  },

  statusline = {
    theme = "default",                    -- default, vscode, vscode_colored or minimal
    separator_style = "round",            -- default, round, block or arrow
    -- default, round, block, and arrow are supported only by the default statusline theme.
    -- the round and block separators are also supported by the minimal theme.
  },

  nvdash = {
    load_on_startup = true,
  },

  cheatsheet = {
    theme = "grid", -- simple/grid
  },

  mason = {
    cmd = true, pkgs = {
      "vim",
      "vimdoc",
      "lua",
      "html",
      "css",
      "javascript",
      "java",
      "c",
      "cpp",
      "markdown",
      "json",
    }
  },
}

return M
