-- Mappings
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

local map = vim.keymap.set
map("n", "<leader>li", require("jdtls").organize_imports, { desc = "Java Organize Imports" })
map("n", "<leader>lv", require("jdtls").extract_variable, { desc = "Java Extract Variable" })
map("n", "<leader>lc", require("jdtls").extract_constant, { desc = "Java Extract Constant" })

map("n", "<leader>lt", require("jdtls").test_nearest_method, { desc = "Java Test Method" })
map("n", "<leader>lT", require("jdtls").test_class, { desc = "Java Test Class" })

map("n", "<leader>lu", ":JdtUpdateConfig<CR>", { silent = true, desc = "Java Update Config" })
map("n", "<leader>lr", ":JdtRestart<CR>", { silent = true, desc = "Java Restart JDTLS" })
