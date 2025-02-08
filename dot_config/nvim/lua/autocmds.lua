vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("LastCursorPlace", {}),
  desc = "return cursor to where it was last time closing the file",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})
