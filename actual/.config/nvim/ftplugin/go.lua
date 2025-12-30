vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = false
vim.opt.textwidth = 120

local map = vim.keymap.set
map("n", "<leader>ls", ":GoTagAdd ", { buffer = true, desc = "Go Serialize Tags Add" })
map("v", "<leader>ls", ":GoTagAdd ", { buffer = true, desc = "Go Serialize Tags Add for selected" })
map({ "n", "v" }, "<leader>lS", ":GoTagRm<CR>", { buffer = true, silent = true, desc = "Go Serialize Tags Remove" })
map("n", "<leader>lt", ":GoTestAdd<CR>", { buffer = true, silent = true, desc = "Go test add for method under cursor" })
map("n", "<leader>lT", ":GoTestsAll<CR>", { buffer = true, silent = true, desc = "Go Tests Add for all methods" })
map("n", "<leader>lE", ":GoTestsExp<CR>", { buffer = true, silent = true, desc = "Go Tests Add for exported methods" })
map("n", "<leader>lg", ":GoGet ", { buffer = true, desc = "Go `get`" })
map("n", "<leader>lm", ":GoMod ", { buffer = true, desc = "Go `mod`" })
map("n", "<leader>lw", ":GoWork ", { buffer = true, desc = "Go `work`" })
map("n", "<leader>lG", ":GoGenerate ", { buffer = true, desc = "Go `generate`" })
map("n", "<leader>li", ":GoImpl ", { buffer = true, desc = "Go Implement interface" })
map("n", "<leader>ld", ":GoCmt<CR>", { buffer = true, silent = true, desc = "Go DocComment generate" })
map("n", "<leader>lj", ":GoJson<CR>", { buffer = true, silent = true, desc = "Go open json2struct generator" })
map("n", "<leader>lJ", ":GoJson ", { buffer = true, desc = "Go json2struct inline" })
map("n", "<leader>le", ":GoIfErr<CR>", { buffer = true, silent = true, desc = "Go generate if err != nil" })
