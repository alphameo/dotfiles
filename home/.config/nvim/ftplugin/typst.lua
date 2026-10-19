local opt = vim.opt_local
opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.spell = true
opt.conceallevel = 2

local map = vim.keymap.set
map("n", "j", "gj", { buffer = true })
map("n", "k", "gk", { buffer = true })
map("n", "<leader>li", ":LspTinymistGetServerInfo<CR>", { buffer = true, silent = true, desc = "Typst server Info" })
map(
  "n",
  "<leader>lt",
  ":LspTinymistGetDocumentTrace<CR>",
  { buffer = true, silent = true, desc = "Typst document Trace" }
)
map(
  "n",
  "<leader>ll",
  ":LspTinymistGetWorkspaceLabels<CR>",
  { buffer = true, silent = true, desc = "Typst workspace Labels" }
)
map(
  "n",
  "<leader>lm",
  ":LspTinymistGetDocumentMetrics<CR>",
  { buffer = true, silent = true, desc = "Typst document Metrics" }
)
map("n", "<leader>lM", ":LspTinymistPinMain<CR>", { buffer = true, silent = true, desc = "Typst pin Main" })
