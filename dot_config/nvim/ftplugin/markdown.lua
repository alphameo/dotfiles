local map = vim.keymap.set
local opt = vim.opt

opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.spelllang = "en_us"
opt.spell = true

map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("n", "<leader>lp", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown Preview" })
map("n", "<leader>lr", ":RenderMarkdown toggle<CR>", { silent = true, desc = "Markdown Render" })
