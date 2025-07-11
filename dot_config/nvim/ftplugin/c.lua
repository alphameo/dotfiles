local map = vim.keymap.set
map({ "n" }, "<leader>lh", ":ClangdSwitchSourceHeader<CR>", { buffer = true, silent = true, desc = "C/C++ Switch Source/Header" })
map({ "n" }, "<leader>lH", ":ClangdTypeHierarchy<CR>", { buffer = true, silent = true, desc = "C/C++ Type Hierarchy" })
map({ "n" }, "<leader>lt", ":ClangdAST<CR>", { buffer = true, silent = true, desc = "C/C++ Abstract Syntax Tree" })
map({ "n" }, "<leader>lm", ":ClangdMemoryUsage<CR>", { buffer = true, silent = true, desc = "C/C++ Memory Usage" })

-- map( "n" , "<leader>lb", ":CMakeBuild<CR>", { buffer = true, silent = true, desc = "CMake Build Project" })
map("n", "<leader>lb", ":CMakeSelectBuildType<CR>", { buffer = true, silent = true, desc = "CMake Build Project" })
map("n", "<leader>lc", ":CMakeClean<CR>", { buffer = true, silent = true, desc = "CMake Clean Project" })
-- map( "n" , "<leader>lr", ":CMakeRun<CR>", { buffer = true, silent = true, desc = "CMake Run Project" })
-- map( "n" , "<leader>lk", ":CMakeOpenRunner<CR>", { buffer = true, silent = true, desc = "CMake Open Runner" })
-- map( "n" , "<leader>lK", ":CMakeStopRunner<CR>", { buffer = true, silent = true, desc = "CMake Stop Runner" })
map("n", "<leader>ld", ":CMakeDebug<CR>", { buffer = true, silent = true, desc = "Cmake Debug" })
map("n", "<leader>lT", ":CMakeRunTest<CR>", { buffer = true, silent = true, desc = "CMake Test Methods" })
map("n", "<leader>le", ":CMakeOpenExecutor<CR>", { buffer = true, silent = true, desc = "CMake Open Executor Window" })
map("n", "<leader>lE", ":CMakeStopExecutor<CR>", { buffer = true, silent = true, desc = "CMake Stop Executor Window" })
map("n", "<leader>lS", ":CMakeSettings<CR>", { buffer = true, silent = true, desc = "CMake Settings Project" })
