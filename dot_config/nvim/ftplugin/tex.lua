local map = vim.keymap.set
local opt = vim.opt

opt.wrap = true
opt.breakindent = true
opt.linebreak = true

opt.spell = true
map({ "n" }, "<leader>K", "<plug>(vimtex-doc-package)", { silent = true, desc = "Vimtex Docs" })
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
