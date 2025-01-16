-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior

-- save file
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", { silent = true, desc = "Save File" })
map({ "n", "i", "v" }, "<C-S-s>", "<cmd> wall <CR>", { silent = true, desc = "Save All Files" })

-- quit file
map("n", "<C-q>", ":q <CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":q! <CR>", { silent = true, desc = "Force Quit" })
map("n", "<C-A-q>", ":qall <CR>", { silent = true, desc = "Quit All" })
map("n", "<C-A-S-q>", ":qall! <CR>", { silent = true, desc = "Force quit All" })

-- Appearance
map("n", "<leader>aw", "<cmd> set wrap! <CR>", { silent = true, desc = "Toggle Line Wrap" })

-- Tabs
-- map('n', '<leader>to', ':tabnew<CR>', { desc = "[T]ab [O]pen" }) -- open new tab
-- map('n', '<leader>tq', ':tabclose<CR>', { desc = [T]ab [Q]uit)) -- close current tab
-- map('n', '<leader>tn', ':tabn<CR>', { desc = "[T]ab [N]ext" }) --  go to next tab
-- map('n', '<leader>tp', ':tabp<CR>', { desc = "[T]ab [P]revious}" }) --  go to previous tab

-- Buffers
map("n", "<A-t>", "<cmd> enew <CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<A-w>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" }) -- close buffer

map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next tab (buffer)" })
map("n", "<A-]>", ":bnext<CR>", { silent = true, desc = "Next tab (buffer)" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "Previous tab (buffer)" })
map("n", "<A-[>", ":bprevious<CR>", { silent = true, desc = "Previous tab (buffer)" })

-- Windows
map("n", "<A-s>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<A-v>", "<C-w>v", { desc = "Window Vertical Split" })
map("n", "<A-q>", "<C-w>q", { desc = "Window Quit" })

map("n", "<A-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<A-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<A-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<A-l>", "<C-w>l", { desc = "Go to right window" })

map("n", "<A-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<A-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<A-,>", "<C-w>>", { desc = "Window Wider" })
map("n", "<A-.>", "<C-w><", { desc = "Window Narower" })

-- Features
map("v", "<", "<gv", { desc = "Indent left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent right" }) -- stay in visual mode after indent

map("n", "x", '"_x', { desc = "Delete char" }) -- delete single character without copying into register

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" }) -- center after scroll down
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" }) -- center after scroll up

map("n", "n", "nzzzv", { desc = "Next occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous occurance" }) -- center after find

-- map("v", "p", '"_dP', { desc = "Paste" }) -- keep last yanked when pasting (doesn't work with cmp snippets)

map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode

-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { silent = true, desc = "Toggle comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
