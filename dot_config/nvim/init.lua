require "options"
require "mappings"
require "autocmds"
require "usercmds"
require "diagnostics"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false },
  rocks = { hererocks = true },
  change_detection = {
    enabled = false,
    notify = false,
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "zipPlugin",
        "tarPlugin",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tohtml",
        "tutor",
        "editorconfig",
        "man",
        "osc52",
        "shada",
        "spellfile",
      },
    },
  },
}

vim.keymap.set({ "n" }, "<leader>L", ":Lazy<CR>", { silent = true, desc = "Mason" })
