local map = vim.keymap.set

map({ "n" }, "<leader>lh", ":ClangdSwitchSourceHeader<CR>", { silent = true, desc = "Switch Source/Header" })
map({ "n" }, "<leader>lH", ":ClangdTypeHierarchy<CR>", { silent = true, desc = "Type Hierarchy" })
map({ "n" }, "<leader>lt", ":ClangdAST<CR>", { silent = true, desc = "Abstract Syntax Tree" })
map({ "n" }, "<leader>ls", ":ClangdSymbolInfo<CR>", { silent = true, desc = "Symbol Info" })
map({ "n" }, "<leader>lm", ":ClangdMemoryUsage<CR>", { silent = true, desc = "Memory Usage" })

map({ "n" }, "<leader>lB", ":CMakeBuild<CR>", { silent = true, desc = "CMake Build Project" })
map({ "n" }, "<leader>lR", ":CMakeRun<CR>", { silent = true, desc = "CMake Run Project" })
map({ "n" }, "<leader>lD", ":CMakeDebug<CR>", { silent = true, desc = "CMake Debug Project" })
map({ "n" }, "<leader>lT", ":CMakeRunTest<CR>", { silent = true, desc = "CMake Run Tests Project" })
map({ "n" }, "<leader>lC", ":CMakeClean<CR>", { silent = true, desc = "CMake Clean Project" })
map({ "n" }, "<leader>lW", ":CMakeOpen<CR>", { silent = true, desc = "CMake Open Executor/Terminal Window" })
