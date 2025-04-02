require("configs.lang.java").start()
-- Mappings
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

vim.keymap.set("n", "<leader>li", require("jdtls").organize_imports, { desc = "Java Organize Imports" })
vim.keymap.set("n", "<leader>lv", require("jdtls").extract_variable, { desc = "Java Extract Variable" })
vim.keymap.set("n", "<leader>lc", require("jdtls").extract_constant, { desc = "Java Extract Constant" })

vim.keymap.set("n", "<leader>lt", require("jdtls").test_nearest_method, { desc = "Java Test Method" })
vim.keymap.set("n", "<leader>lT", require("jdtls").test_class, { desc = "Java Test Class" })

vim.keymap.set("n", "<leader>lu", "<Cmd> JdtUpdateConfig<CR>", { silent = true, desc = "Java Update Config" })
vim.keymap.set("n", "<leader>lr", "<Cmd> JdtRestart<CR>", { silent = true, desc = "Java Restart JDTLS" })
