local map = vim.keymap.set

map({ "n" }, "<leader>lG", ":CMakeGenerate<CR>", { silent = true, desc = "CMake Generate Project" })
map({ "n" }, "<leader>l.", ":CMakeSelectCwd<CR>", { silent = true, desc = "CMake Select Root" })
