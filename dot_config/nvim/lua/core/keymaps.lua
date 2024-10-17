-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- save file
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
map("n", "<leader>s", "<cmd> w <CR>", { desc = "Save File" })
map("n", "<leader>S", "<cmd> w <CR>", { desc = "Save All Files" })

-- quit file
map({ "n", "i", "v" }, "<C-q>", "<cmd> q <CR>", { desc = "Quit" })
map("n", "<leader>q", "<cmd> q <CR>", { desc = "Quit" })
map({ "n", "i", "v" }, "<C-S-q>", "<cmd> q! <CR>", { desc = "Force Quit" })
map("n", "<leader>Q", "<cmd> q! <CR>", { desc = "Force quit" })

-- delete single character without copying into register
map("n", "x", '"_x', { desc = "Delete char" })

-- Vertical scroll and center
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Find and center
map("n", "n", "nzzzv", { desc = "Next occurance" })
map("n", "N", "Nzzzv", { desc = "Previous occurance" })

map("n", "<leader>aw", "<cmd>set wrap!<CR>", { desc = "Toggle Line Wrap" })

-- Tabs
-- map('n', '<leader>to', ':tabnew<CR>', { desc = "[T]ab [O]pen" }) -- open new tab
-- map('n', '<leader>tq', ':tabclose<CR>', { desc = [T]ab [Q]uit)) -- close current tab
-- map('n', '<leader>tn', ':tabn<CR>', { desc = "[T]ab [N]ext" }) --  go to next tab
-- map('n', '<leader>tp', ':tabp<CR>', { desc = "[T]ab [P]revious}" }) --  go to previous tab

-- Buffers
map("n", "<leader>tn", "<cmd> enew <CR>", { desc = "Tab New" }) -- new buffer
map("n", "<leader>tq", ":Bdelete!<CR>", { desc = "Tab Quit" }) -- close buffer
-- Navigate between buffers
map("n", "<C-Tab>", ":bnext<CR>", { desc = "Next tab (buffer)" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { desc = "Previous tab (buffer)" })

-- Window management
map("n", "<leader>wv", "<C-w>v", { desc = "Splitindow Vertical" }) -- split window vertically
map("n", "<leader>v", "<C-w>v", { desc = "Split Window Vertical" }) -- split window vertically
map("n", "<leader>wh", "<C-w>s", { desc = "Split Window Horizontal" }) -- split window horizontally
map("n", "<leader>h", "<C-w>s", { desc = "Split Window Horizontal" }) -- split window horizontally
map("n", "<leader>we", "<C-w>=", { desc = "Make Windows Equal" }) -- make split windows equal width & height
map("n", "<leader>wq", ":close<CR>", { desc = "Window Quit" }) -- close current split window

-- Navigate between splits
map("n", "<A-k>", ":wincmd k<CR>", { desc = "Go to upper window" })
map("n", "<A-j>", ":wincmd j<CR>", { desc = "Go to lower window" })
map("n", "<A-h>", ":wincmd h<CR>", { desc = "Go to left window" })
map("n", "<A-l>", ":wincmd l<CR>", { desc = "Go to right window" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Keep last yanked when pasting
map("v", "p", '"_dP', { desc = "Paste" })

map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode

-- Move text up and down
map("v", "<A-k>", ":m .-2<CR>==v", { desc = "Move line up" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m .+1<CR>==v", { desc = "Move line down" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { desc = "Toggle comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })

map("i", "C-h", "<del>", { desc = "Delete char" })
