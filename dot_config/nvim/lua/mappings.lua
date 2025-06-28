-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior

-- Save file
map("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save File" })
map("n", "<C-S-s>", ":wall<CR>", { silent = true, desc = "Save All Files" })

-- Quit file
map("n", "<C-q>", ":q<CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":q!<CR>", { silent = true, desc = "Force Quit" })
map("n", "<C-A-q>", ":qall<CR>", { silent = true, desc = "Quit All" })
map("n", "<C-A-S-q>", ":qall!<CR>", { silent = true, desc = "Force quit All" })

-- Appearance
map("n", "<leader>aw", ":set wrap!<CR>", { silent = true, desc = "Toggle Line Wrap" })

-- Tabs
-- map('n', '<leader>to', ':tabnew<CR>', { desc = "[T]ab [O]pen" }) -- open new tab
-- map('n', '<leader>tq', ':tabclose<CR>', { desc = [T]ab [Q]uit)) -- close current tab
-- map('n', '<leader>tn', ':tabn<CR>', { desc = "[T]ab [N]ext" }) --  go to next tab
-- map('n', '<leader>tp', ':tabp<CR>', { desc = "[T]ab [P]revious}" }) --  go to previous tab

-- Buffers
map("n", "<A-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<A-w>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" }) -- close buffer

map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "Previous Tab (buffer)" })

-- Windows
map("n", "<A-s>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<A-v>", "<C-w>v", { desc = "Window Vertical Split" })
map("n", "<A-q>", "<C-w>q", { desc = "Window Quit" })

map("n", "<A-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<A-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<A-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<A-l>", "<C-w>l", { desc = "Go to Right Window" })

map("n", "<A-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<A-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<A-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<A-,>", "<C-w><", { desc = "Window Narower" })

-- Features
map("v", "<", "<gv", { desc = "Indent left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent right" }) -- stay in visual mode after indent

map("n", "x", '"_x', { desc = "Delete char" }) -- delete single character without copying into register

map("n", "<C-d>", "<C-d>zz", { desc = "Page down" }) -- center after scroll down
map("n", "<C-u>", "<C-u>zz", { desc = "Page up" }) -- center after scroll up
map("n", "n", "nzzzv", { desc = "Next occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous occurance" }) -- center after find

map("n", "<C-e>", "5<C-e>", { desc = "Scroll down" })
map("n", "<C-y>", "5<C-y>", { desc = "Scroll up" })

-- map("v", "p", "_dp", { desc = "Paste" }) -- keep last yanked when pasting (doesn't work with cmp snippets)
-- map("v", "P", "_dP", { desc = "Paste pre" }) -- keep last yanked when pasting (doesn't work with cmp snippets)
vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" })

-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { silent = true, desc = "Toggle comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })

-- Terminal
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("n", "<leader>tf", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("n", "<A-\\>", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<A-\\>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })

map("n", "<leader>ts", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("n", "<C-\\>", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<leader>ts", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<C-\\>", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })

map("t", "<C-q>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })
map("t", "<A-t>", "<C-\\><C-n><A-t>", { silent = true, remap = true, desc = "Term: Tab New" })
map("t", "<A-w>", "<C-\\><C-n><A-w>", { silent = true, remap = true, desc = "Term: Tab Quit" })
map("t", "<A-]>", "<C-\\><C-n><A-]>", { silent = true, remap = true, desc = "Term: Next Tab (buffer)" })
map("t", "<A-[>", "<C-\\><C-n><A-[>", { silent = true, remap = true, desc = "Term: Previous Tab (buffer)" })
map("t", "<A-s>", "<C-\\><C-n><A-s>", { silent = true, remap = true, desc = "Term: Window Horizontal Split" })
map("t", "<A-v>", "<C-\\><C-n><A-v>", { silent = true, remap = true, desc = "Term: Window Vertical Split" })
map("t", "<A-q>", "<C-\\><C-n><A-q>", { silent = true, remap = true, desc = "Term: Window Quit" })
map("t", "<A-k>", "<C-\\><C-n><C-k>", { silent = true, remap = true, desc = "Term: Go to Upper window" })
map("t", "<A-j>", "<C-\\><C-n><A-j>", { silent = true, remap = true, desc = "Term: Go to Lower window" })
map("t", "<A-h>", "<C-\\><C-n><A-h>", { silent = true, remap = true, desc = "Term: Go to Left window" })
map("t", "<A-l>", "<C-\\><C-n><A-l>", { silent = true, remap = true, desc = "Term: Go to Right window" })
map("t", "<A-=>", "<C-\\><C-n><A-=>", { silent = true, remap = true, desc = "Term: Window Taller" })
map("t", "<A-->", "<C-\\><C-n><A-->", { silent = true, remap = true, desc = "Term: Window Shorter" })
map("t", "<A-.>", "<C-\\><C-n><A-.>", { silent = true, remap = true, desc = "Term: Window Wider" })
map("t", "<A-,>", "<C-\\><C-n><A-,>", { silent = true, remap = true, desc = "Term: Window Narrower" })

-- LSP defaults
map("n", "K", vim.lsp.buf.hover, { desc = "Show Doc Hover" })
map("n", "grn", vim.lsp.buf.rename, { desc = "Code Rename" })
map({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "Code Actions" })
map("n", "grr", vim.lsp.buf.references, { desc = "Go to References" })
map("n", "gri", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "gO", vim.lsp.buf.document_symbol, { desc = "Go to Document Symbols" })
map("i", "<C-s>", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })
