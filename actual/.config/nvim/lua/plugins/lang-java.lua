local ft = "java"
vim.api.nvim_create_autocmd("FileType", {
  pattern = ft,
  callback = function()
    vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
    vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
    vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
    vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

    local map = vim.keymap.set
    local jdtls = require "jdtls"
    map("n", "<leader>li", jdtls.organize_imports, { buffer = true, desc = "Java Organize Imports" })
    map("n", "<leader>lv", jdtls.extract_variable, { buffer = true, desc = "Java Extract Variable" })
    map("n", "<leader>lc", jdtls.extract_constant, { buffer = true, desc = "Java Extract Constant" })

    map("n", "<leader>lt", jdtls.test_nearest_method, { buffer = true, desc = "Java Test Method" })
    map("n", "<leader>lT", jdtls.test_class, { buffer = true, desc = "Java Test Class" })

    map("n", "<leader>lu", ":JdtUpdateConfig<CR>", { buffer = true, silent = true, desc = "Java Update Config" })
    map("n", "<leader>lr", ":JdtRestart<CR>", { buffer = true, silent = true, desc = "Java Restart JDTLS" })
  end,
})
return {
  "mfussenegger/nvim-jdtls",
  lazy = true,
  ft = ft,
}
