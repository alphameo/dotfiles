-- Markdown specific settings
vim.opt.wrap = true -- Wrap text
vim.opt.breakindent = true -- Match indent on line break
vim.opt.linebreak = true -- Line break on whole words

-- Allow j/k when navigating wrapped lines
vim.keymap.set("n", "j", "gj", { silent = true })
vim.keymap.set("n", "k", "gk", { silent = true })

-- Spell check
vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.keymap.set("n", "<leader>lp", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>lr", ":RenderMarkdown toggle<CR>", { silent = true, desc = "Markdown Render" })
