local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require "options"
require "mappings"
require "autocmds"
require("lazy").setup "plugins"
vim.keymap.set({ "n" }, "<leader>L", ":Lazy<cr>", { silent = true, desc = "Mason" })

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
