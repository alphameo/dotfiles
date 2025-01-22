require "options"
require "mappings"

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
  require "plugins.core.cmp",
  require "plugins.core.dap",
  require "plugins.core.fmt",
  require "plugins.core.lsp",
  require "plugins.core.mason",
  require "plugins.core.treesitter",
  require "plugins.appearance.bufferline",
  require "plugins.appearance.colorizer",
  require "plugins.appearance.greetingscreen",
  require "plugins.appearance.indent-blankline",
  require "plugins.appearance.lualine",
  require "plugins.appearance.noice",
  require "plugins.appearance.onedark-theme",
  require "plugins.appearance.todo-comments",
  require "plugins.features.autopairs",
  require "plugins.features.autoindent",
  require "plugins.features.codesnap",
  require "plugins.features.git",
  require "plugins.features.langmapper",
  require "plugins.features.refactoring",
  require "plugins.features.surround",
  require "plugins.features.treeSJ",
  require "plugins.features.trouble",
  require "plugins.features.ts-comments",
  require "plugins.features.which-key",
  require "plugins.navigation.harpoon",
  require "plugins.navigation.neo-tree",
  require "plugins.navigation.spectre",
  require "plugins.navigation.telescope",
  require "plugins.lang.ccpp",
  require "plugins.lang.cmake",
  require "plugins.lang.go",
  require "plugins.lang.java",
  require "plugins.lang.json-yaml",
  require "plugins.lang.markdown",
  require "plugins.lang.python",
  require "plugins.lang.rust",
  require "plugins.lang.sql",
  require "plugins.lang.tex",
}

-- Language Configs
require "configs.lang.bash"
require "configs.lang.ccpp"
require "configs.lang.cmake"
require "configs.lang.css"
require "configs.lang.go"
require "configs.lang.html"
require "configs.lang.java"
require "configs.lang.json"
require "configs.lang.kotlin"
require "configs.lang.lua"
require "configs.lang.markdown"
require "configs.lang.php"
require "configs.lang.python"
require "configs.lang.rust"
require "configs.lang.sql"
require "configs.lang.tex"
require "configs.lang.ts-js"
require "configs.lang.toml"
require "configs.lang.xml"
require "configs.lang.yaml"

require("langmapper").automapping { buffer = false }
