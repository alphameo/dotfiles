local opt = vim.opt
opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.spell = true

local map = vim.keymap.set
map("n", "<leader>K", "<plug>(vimtex-doc-package)", { buffer = true, silent = true, desc = "Vimtex Docs" })
map("n", "j", "gj", { buffer = true })
map("n", "k", "gk", { buffer = true })
