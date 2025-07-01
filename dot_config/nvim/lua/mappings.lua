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
