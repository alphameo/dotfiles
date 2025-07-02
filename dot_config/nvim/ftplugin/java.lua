vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

local map = vim.keymap.set
map(
  "n",
  "<leader>li",
  ":lua require('jdtls').organize_imports()<CR>",
  { buffer = true, silent = true, desc = "Java Organize Imports" }
)
map(
  "n",
  "<leader>lv",
  ":lua require('jdtls').extract_variable()<CR>",
  { buffer = true, silent = true, desc = "Java Extract Variable" }
)
map(
  "n",
  "<leader>lc",
  ":lua require('jdtls').extract_constant()<CR>",
  { buffer = true, silent = true, desc = "Java Extract Constant" }
)

map(
  "n",
  "<leader>lt",
  ":lua require('jdtls').test_nearest_method",
  { buffer = true, silent = true, desc = "Java Test Method" }
)
map(
  "n",
  "<leader>lT",
  ":lua require('jdtls').test_class()<CR>",
  { buffer = true, silent = true, desc = "Java Test Class" }
)

map("n", "<leader>lu", ":JdtUpdateConfig<CR>", { buffer = true, silent = true, desc = "Java Update Config" })
map("n", "<leader>lr", ":JdtRestart<CR>", { buffer = true, silent = true, desc = "Java Restart JDTLS" })
