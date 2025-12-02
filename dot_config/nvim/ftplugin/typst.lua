local opt = vim.opt_local
opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.spell = true
opt.conceallevel = 2

-- stylua: ignore
local map = vim.keymap.set
map("n", "j", "gj", { buffer = true })
map("n", "k", "gk", { buffer = true })

map("n", "<leader>lp", ":TypstPreviewToggle<CR>", { buffer = true, silent = true, desc = "Typst Preview Toggle" })

map("n", "<leader>les", ":LspTinymistExportSvg<CR>", { buffer = true, silent = true, desc = "Typst Export SVG" })
map("n", "<leader>lep", ":LspTinymistExportPng<CR>", { buffer = true, silent = true, desc = "Typst Export PNG" })
map("n", "<leader>leP", ":LspTinymistExportPdf<CR>", { buffer = true, silent = true, desc = "Typst Export PDF" })
map("n", "<leader>lem", ":LspTinymistExportPdf<CR>", { buffer = true, silent = true, desc = "Typst Export Markdown" })
map("n", "<leader>li", ":LspTinymistGetServerInfo<CR>", { buffer = true, silent = true, desc = "Typst server Info" })
map("n", "<leader>lt", ":LspTinymistGetDocumentTrace<CR>", { buffer = true, silent = true, desc = "Typst document Trace" })
map("n", "<leader>ll", ":LspTinymistGetWorkspaceLabels<CR>", { buffer = true, silent = true, desc = "Typst workspace Labels" })
map("n", "<leader>lm", ":LspTinymistGetDocumentMetrics<CR>", { buffer = true, silent = true, desc = "Typst document Metrics" })
map("n", "<leader>lM", ":LspTinymistPinMain<CR>", { buffer = true, silent = true, desc = "Typst pin Main" })
