-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- save file
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
map("n", "<leader>fs", "<cmd> w <CR>", { desc = "[F]ile [S]ave" })

-- quit file
map({ "n", "i", "v" }, "<C-q>", "<cmd> q <CR>", { desc = "Quit file" })
map("n", "<leader>fq", "<cmd> q <CR>", { desc = "[F]ile [Q]uit" })
map("n", "<leader>ffq", "<cmd> q! <CR>", { desc = "[F]ile [F]orce [Q]uit" })

-- delete single character without copying into register
map("n", "x", '"_x', { desc = "Delete char" })

-- Vertical scroll and center
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Find and center
map("n", "n", "nzzzv", { desc = "Next occurance" })
map("n", "N", "Nzzzv", { desc = "Previous occurance" })

map("n", "<leader>aw", "<cmd>set wrap!<CR>", { desc = "[A]ppearance: Toggle [W]rap" })

-- Tabs
-- map('n', '<leader>to', ':tabnew<CR>', { desc = "[T]ab [O]pen" }) -- open new tab
-- map('n', '<leader>tq', ':tabclose<CR>', { desc = [T]ab [Q]uit)) -- close current tab
-- map('n', '<leader>tn', ':tabn<CR>', { desc = "[T]ab [N]ext" }) --  go to next tab
-- map('n', '<leader>tp', ':tabp<CR>', { desc = "[T]ab [P]revious}" }) --  go to previous tab

-- Buffers
map("n", "<leader>tn", "<cmd> enew <CR>", { desc = "[T]ab [N]ew (buffer)" }) -- new buffer
map("n", "<leader>tq", ":Bdelete!<CR>", { desc = "[T]ab [Q]uit (buffer)" }) -- close buffer
-- Navigate between buffers
map("n", "<C-Tab>", ":bnext<CR>", { desc = "Next tab (buffer)" })
map("n", "<C-S-Tab>", ":bprevious<CR>", { desc = "Previous tab (buffer)" })

-- Window management
map("n", "<leader>wv", "<C-w>v", { desc = "Split [W]indow [V]ertical" }) -- split window vertically
map("n", "<leader>wh", "<C-w>s", { desc = "Split [W]indow [H]orizontal" }) -- split window horizontally
map("n", "<leader>we", "<C-w>=", { desc = "Make [W]indows [E]qual" }) -- make split windows equal width & height
map("n", "<leader>wq", ":close<CR>", { desc = "[W]indow [Q]uit" }) -- close current split window

-- Navigate between splits
map("n", "<C-k>", ":wincmd k<CR>", { desc = "Go to upper window" })
map("n", "<C-j>", ":wincmd j<CR>", { desc = "Go to lower window" })
map("n", "<C-h>", ":wincmd h<CR>", { desc = "Go to left window" })
map("n", "<C-l>", ":wincmd l<CR>", { desc = "Go to right window" })

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