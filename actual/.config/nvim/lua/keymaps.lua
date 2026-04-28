vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Insert movements
map("c", "<M-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<M-l>", "<Right>", { silent = false, desc = "Right" })
map("i", "<M-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<M-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<M-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<M-l>", "<Right>", { noremap = false, desc = "Right" })
map("t", "<M-h>", "<Left>", { desc = "Left" })
map("t", "<M-j>", "<Down>", { desc = "Down" })
map("t", "<M-k>", "<Up>", { desc = "Up" })
map("t", "<M-l>", "<Right>", { desc = "Right" })

-- Escape Insert
map("i", "jj", "<ESC>", { desc = "Exit INSERT MODE" })

-- Buffers
map("n", "<M-]>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "<M-[>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
map("n", "<M-Backspace>", "<C-^>", { silent = true, desc = "Switch to last buffer" })

map("n", "]b", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "[b", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
map("n", "<C-n>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "<C-p>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "<C-S-Tab>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })

-- Windows
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-Left>", "<C-w>H", { desc = "Move Window to the Left" })
map("n", "<C-Right>", "<C-w>L", { desc = "Move Window to the Right" })
map("n", "<C-Down>", "<C-w>J", { desc = "Move Window to the Lower" })
map("n", "<C-Up>", "<C-w>K", { desc = "Move Window to the Upper" })
map("n", "<C-q>", ":close<CR>", { silent = true, desc = "Close Window" })

map("n", "<C-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<C-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<C-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<C-,>", "<C-w><", { desc = "Window Narower" })

-- Comments
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })

-- Terminals
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })
map("t", "<C-q>", "<C-\\><C-n>:close<CR>", { silent = true, remap = true, desc = "Exit Terminal Mode" })

-- Text Movement
map("v", "<", "<gv", { desc = "Indent Left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent Right" }) -- stay in visual mode after indent

map("n", "<M-j>", ":m .+1<CR>==", { silent = true, desc = "Move Line Down" })
map("n", "<M-k>", ":m .-2<CR>==", { silent = true, desc = "Move Line Up" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })

-- Jumps
map("n", "[j", "<C-o>", { desc = "Jump Back" })
map("n", "]j", "<C-i>", { desc = "Jump Forward" })

-- Diffs
map("n", "<leader>DA", ":diffthis<CR>", { silent = true, desc = "Diff Add" })
map("n", "<leader>DR", ":diffoff<CR>", { silent = true, desc = "Diff Remove" })
map("n", "<leader>DO", ":diffoff!<CR>", { silent = true, desc = "Diff Off" })
map("n", "<leader>DU", ":diffupdate<CR>", { silent = true, desc = "Diff Update" })
map({ "n", "v" }, "<leader>DP", ":diffput<CR>", { silent = true, desc = "Diff Put" })
map({ "n", "v" }, "<leader>DG", ":diffget<CR>", { silent = true, desc = "Diff Get" })

-- Diagnostics
map("n", "[d", function()
  return vim.diagnostic.jump {
    count = -1,
    float = false,
  }
end, { silent = true, desc = "Previous Diagnostic" })
map("n", "]d", function()
  return vim.diagnostic.jump {
    count = 1,
    float = false,
  }
end, { silent = true, desc = "Next Diagnostic" })

map("n", "gd", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
  })
end, { silent = true, desc = "Reveal Diagnostic" })

-- Vim Pack
map({ "n" }, "<leader>pu", vim.pack.update, { silent = true, desc = "vim.pack.update" })

-- Other Features
map("n", "<leader>E", ":Explore<CR>", { silent = true, desc = "Explorer" })
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("n", "<leader>nn", ":messages<CR>", { silent = true, desc = "Notifications List" })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

map("n", "<leader>..", function()
  vim.cmd "e $MYVIMRC | cd %:p:h"
  vim.notify("Current working directory: " .. vim.fn.getcwd())
end, { silent = true, desc = "Open nvim config" })
