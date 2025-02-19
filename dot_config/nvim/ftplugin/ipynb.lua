vim.keymap.set("n", "<leader>li", ":MoltenInit<CR>", { silent = true, desc = "Molten Initialize" })
vim.keymap.set("n", "<leader>le", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Operator Selection" })
vim.keymap.set("n", "<leader>ll", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Evaluate Line" })
vim.keymap.set("n", "<leader>lr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate Cell" })
vim.keymap.set(
  "v",
  "<leader>lR",
  ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "Evaluate visual selection" }
)
vim.keymap.set("n", "<leader>ld", ":MoltenDelete<CR>", { silent = true, desc = "Delete Cell" })
vim.keymap.set("n", "<leader>lh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide Output" })
vim.keymap.set("n", "<leader>ls", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "Show/Enter Output" })
