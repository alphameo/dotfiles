local map = vim.keymap.set

vim.cmd.packadd "nvim.undotree"
map({ "n" }, "<leader>u", ":Undotree<CR>", { silent = true, desc = "Undotree" })

vim.cmd.packadd "nvim.difftool"
map("n", "<leader>DA", ":diffthis<CR>", { silent = true, desc = "Diff Add" })
map("n", "<leader>DR", ":diffoff<CR>", { silent = true, desc = "Diff Remove" })
map("n", "<leader>DO", ":diffoff!<CR>", { silent = true, desc = "Diff Off" })
map("n", "<leader>DU", ":diffupdate<CR>", { silent = true, desc = "Diff Update" })
map({ "n", "v" }, "<leader>DP", ":diffput<CR>", { silent = true, desc = "Diff Put" })
map({ "n", "v" }, "<leader>DG", ":diffget<CR>", { silent = true, desc = "Diff Get" })
