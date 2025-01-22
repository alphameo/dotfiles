local map = vim.keymap.set

map({ "n" }, "<leader>lG", ":CMakeGenerate<CR>", { silent = true, desc = "CMake Generate Project" })
map({ "n" }, "<leader>lS", ":CMakeSettings<CR>", { silent = true, desc = "CMake Settings Project" })
map({ "n" }, "<leader>lR", ":CMakeSelectCwd<CR>", { silent = true, desc = "CMake Select Root" })
