local ft = { "cpp", "c", "cmake" }
return {
  "Civitasv/cmake-tools.nvim",
  lazy = true,
  ft = ft,
  cmd = { "CMakeGenerate" },
  opts = {},
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        local map = vim.keymap.set
        -- map( "n" , "<leader>lb", ":CMakeBuild<CR>", { buffer = true, silent = true, desc = "CMake Build Project" })
        map(
          "n",
          "<leader>lb",
          ":CMakeSelectBuildType<CR>",
          { buffer = true, silent = true, desc = "CMake Build Project" }
        )
        map("n", "<leader>lc", ":CMakeClean<CR>", { buffer = true, silent = true, desc = "CMake Clean Project" })
        -- map( "n" , "<leader>lr", ":CMakeRun<CR>", { buffer = true, silent = true, desc = "CMake Run Project" })
        -- map( "n" , "<leader>lk", ":CMakeOpenRunner<CR>", { buffer = true, silent = true, desc = "CMake Open Runner" })
        -- map( "n" , "<leader>lK", ":CMakeStopRunner<CR>", { buffer = true, silent = true, desc = "CMake Stop Runner" })
        map("n", "<leader>ld", ":CMakeDebug<CR>", { buffer = true, silent = true, desc = "Cmake Debug" })
        map("n", "<leader>lT", ":CMakeRunTest<CR>", { buffer = true, silent = true, desc = "CMake Test Methods" })
        map(
          "n",
          "<leader>le",
          ":CMakeOpenExecutor<CR>",
          { buffer = true, silent = true, desc = "CMake Open Executor Window" }
        )
        map(
          "n",
          "<leader>lE",
          ":CMakeStopExecutor<CR>",
          { buffer = true, silent = true, desc = "CMake Stop Executor Window" }
        )
        map("n", "<leader>lS", ":CMakeSettings<CR>", { buffer = true, silent = true, desc = "CMake Settings Project" })
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "cmake",
      callback = function()
        local map = vim.keymap.set
        map("n", "<leader>lG", ":CMakeGenerate<CR>", { buffer = true, silent = true, desc = "CMake Generate Project" })
        map("n", "<leader>l.", ":CMakeSelectCwd<CR>", { buffer = true, silent = true, desc = "CMake Select Root" })
      end,
    })
  end,
}
