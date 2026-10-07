local opt = vim.opt_local
opt.wrap = true

local map = vim.keymap.set
map("n", "j", "gj", { buffer = true })
map("n", "k", "gk", { buffer = true })
