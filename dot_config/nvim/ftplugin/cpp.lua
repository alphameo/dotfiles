vim.keymap.set(
  { "n" },
  "<leader>lh",
  ":ClangdSwitchSourceHeader<CR>",
  { silent = true, desc = "Switch Source/Header (C/C++)" }
)
