vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true

vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.keymap.set("n", "<leader>lp", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>lr", ":RenderMarkdown toggle<CR>", { silent = true, desc = "Markdown Render" })
