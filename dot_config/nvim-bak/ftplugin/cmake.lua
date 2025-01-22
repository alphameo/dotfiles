vim.keymap.set({ "n" }, "<leader>lG", ":CMakeGenerate<CR>", { silent = true, desc = "CMake Generate Project" })
vim.keymap.set({ "n" }, "<leader>lS", ":CMakeSettings<CR>", { silent = true, desc = "CMake Settings Project" })
vim.keymap.set({ "n" }, "<leader>lR", ":CMakeSelectCwd<CR>", { silent = true, desc = "CMake Select Root" })
