vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = false
vim.opt.textwidth = 120

local map = vim.keymap.set
map("n", "<leader>ld", ":GoInstallDeps<CR>", { buffer = true, silent = true, desc = "Go install dependencies" })
map({ "n", "v" }, "<leader>lta", ":GoTagAdd ", { buffer = true, desc = "Go add tag type for struct" })
map({ "n", "v" }, "<leader>ltr", ":GoTagRm ", { buffer = true, desc = "Go remove tag type from struct" })
map("n", "<leader>lTt", ":GoTestAdd<CR>", { buffer = true, silent = true, desc = "Go add test for method under cursor" })
map("n", "<leader>lTa", ":GoTestsAll<CR>", { buffer = true, silent = true, desc = "Go add tests for all methods" })
map("n", "<leader>lTe", ":GoTestsExp<CR>", { buffer = true, silent = true, desc = "Go add tests for exported methods" })
map("n", "<leader>lg", ":GoGet ", { buffer = true, desc = "Go get" })
map("n", "<leader>lm", ":GoMod ", { buffer = true, desc = "Go mod" })
map("n", "<leader>lw", ":GoWork ", { buffer = true, desc = "Go work" })
map("n", "<leader>lG", ":GoGenerate ", { buffer = true, desc = "Go generate" })
map("n", "<leader>li", ":GoImpl ", { buffer = true, desc = "Go implement interface" })
map("n", "<leader>lc", ":GoCmt<CR>", { buffer = true, silent = true, desc = "Go generate doc comment" })
map("n", "<leader>lj", ":GoJson<CR>", { buffer = true, silent = true, desc = "Go open generator for structs from json" })
map("n", "<leader>lJ", ":GoJson ", { buffer = true, desc = "Go inline generate struct from json" })
map("n", "<leader>le", ":GoIfErr<CR>", { buffer = true, silent = true, desc = "Go generate if err != nil" })
