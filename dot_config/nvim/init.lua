require "options"
require "mappings"
require "autocmds"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  require "plugins.appearance.bufferline",
  require "plugins.appearance.colorizer",
  require "plugins.appearance.greetingscreen",
  require "plugins.appearance.indent-blankline",
  require "plugins.appearance.lualine",
  require "plugins.appearance.noice",
  require "plugins.appearance.onedark-theme",
  require "plugins.appearance.todo-comments",
  require "configs.treesitter",
  require "configs.lsp",
  require "configs.fmt",
  require "configs.lint",
  require "configs.dap",
  require "configs.cmp",
  require "configs.mason",
  require "plugins.features.autopairs",
  require "plugins.features.codesnap",
  require "plugins.features.git",
  require "plugins.features.langmapper",
  require "plugins.features.refactoring",
  require "plugins.features.surround",
  require "plugins.features.treeSJ",
  require "plugins.features.trouble",
  require "plugins.features.ts-comments",
  require "plugins.features.which-key",
  require "plugins.lang.java",
  require "plugins.lang.markdown",
  require "plugins.lang.tex",
  require "plugins.lang.ccpp",
  require "plugins.navigation.telescope",
  require "plugins.navigation.harpoon",
  require "plugins.navigation.spectre",
  require "plugins.navigation.neo-tree",
}
