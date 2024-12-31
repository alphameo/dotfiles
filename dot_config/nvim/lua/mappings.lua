-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior

-- save file
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", { desc = "Save File" })
map("n", "<leader>s", "<cmd> w <CR>", { desc = "Save File" })
map({ "n", "i", "v" }, "<C-S-s>", "<cmd> wall <CR>", { desc = "Save All Files" })
map("n", "<leader>S", "<cmd> wall <CR>", { desc = "Save All Files" })

-- quit file
map("n", "<C-q>", "<cmd> q <CR>", { desc = "Quit" })
map("n", "<C-S-q>", "<cmd> qall <CR>", { desc = "Quit All" })
map("n", "<leader>q", "<cmd> q! <CR>", { desc = "Force Quit" })
map("n", "<leader>Q", "<cmd> qall! <CR>", { desc = "Force quit All" })

-- Appearance
map("n", "<leader>aw", "<cmd> set wrap! <CR>", { desc = "Toggle Line Wrap" })

-- Tabs
-- map('n', '<leader>to', ':tabnew<CR>', { desc = "[T]ab [O]pen" }) -- open new tab
-- map('n', '<leader>tq', ':tabclose<CR>', { desc = [T]ab [Q]uit)) -- close current tab
-- map('n', '<leader>tn', ':tabn<CR>', { desc = "[T]ab [N]ext" }) --  go to next tab
-- map('n', '<leader>tp', ':tabp<CR>', { desc = "[T]ab [P]revious}" }) --  go to previous tab

-- Buffers
map("n", "<leader>tn", "<cmd> enew <CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<leader>tq", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" }) -- close buffer

-- Buffers navigation
map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next tab (buffer)" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "Previous tab (buffer)" })

-- Windows navigation
map("n", "<A-k>", ":wincmd k<CR>", { silent = true, desc = "Go to upper window" })
map("n", "<A-j>", ":wincmd j<CR>", { silent = true, desc = "Go to lower window" })
map("n", "<A-h>", ":wincmd h<CR>", { silent = true, desc = "Go to left window" })
map("n", "<A-l>", ":wincmd l<CR>", { silent = true, desc = "Go to right window" })

-- Features
map("v", "<", "<gv", { desc = "Indent left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent right" }) -- stay in visual mode after indent

map("n", "x", '"_x', { desc = "Delete char" }) -- delete single character without copying into register

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" }) -- center after scroll down
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" }) -- center after scroll up

map("n", "n", "nzzzv", { desc = "Next occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous occurance" }) -- center after find

map("v", "p", '"_dP', { desc = "Paste" }) -- keep last yanked when pasting

map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode

-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { silent = true, desc = "Toggle comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
