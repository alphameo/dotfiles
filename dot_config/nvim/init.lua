require "options"
require "mappings"

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
-- NOTE: Here is where you install your plugins.
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
  require "configs.dap",
  require "configs.cmp",
  require "plugins.features.autopairs",
  require "plugins.features.surround",
  require "plugins.features.which-key",
  require "plugins.features.git",
  require "plugins.features.refactoring",
  require "plugins.features.trouble",
  require "plugins.features.treeSJ",
  require "plugins.features.ts-comments",
  require "plugins.lang.markdown",
  require "plugins.lang.tex",
  require "plugins.navigation.telescope",
  require "plugins.navigation.harpoon",
  require "plugins.navigation.neo-tree",
}
