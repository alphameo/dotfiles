vim.cmd.packadd "nvim.undotree"
vim.keymap.set({ "n" }, "<leader>u", ":Undotree<CR>", { silent = true, desc = "Undotree" })
vim.cmd.packadd "nvim.difftool"
