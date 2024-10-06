-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
-- local opts = { noremap = true, silent = true }

local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

-- save file
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", opts("Save file"))
vim.keymap.set("n", "<leader>fs", "<cmd> w <CR>", opts("[F]ile [S]ave"))

-- quit file
vim.keymap.set({ "n", "i", "v" }, "<C-q>", "<cmd> q <CR>", opts("Quit file"))
vim.keymap.set("n", "<leader>fq", "<cmd> q <CR>", opts("[F]ile [Q]uit"))
vim.keymap.set("n", "<leader>ffq", "<cmd> q! <CR>", opts("[F]ile [F]orce [Q]uit"))

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts("Delete char"))

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("Scroll down"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("Scroll up"))

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts("Next occurance"))
vim.keymap.set("n", "N", "Nzzzv", opts("Previous occurance"))

vim.keymap.set("n", "<leader>aw", "<cmd>set wrap!<CR>", opts("[A]ppearance: Toggle [W]rap"))

-- Tabs
-- vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts("[T]ab [O]pen")) -- open new tab
-- vim.keymap.set('n', '<leader>tq', ':tabclose<CR>', opts([T]ab [Q]uit)) -- close current tab
-- vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts("[T]ab [N]ext")) --  go to next tab
-- vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts("[T]ab [P]revious}")) --  go to previous tab

-- Buffers
vim.keymap.set("n", "<leader>tn", "<cmd> enew <CR>", opts("[T]ab [N]ew (buffer)")) -- new buffer
vim.keymap.set("n", "<leader>tq", ":Bdelete!<CR>", opts("[T]ab [Q]uit (buffer)")) -- close buffer
-- Navigate between buffers
vim.keymap.set("n", "<C-Tab>", ":bnext<CR>", opts("Next tab (buffer)"))
vim.keymap.set("n", "<C-S-Tab>", ":bprevious<CR>", opts("Previous tab (buffer)"))

-- Window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", opts("Split [W]indow [V]ertical")) -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", opts("Split [W]indow [H]orizontal")) -- split window horizontally
vim.keymap.set("n", "<leader>we", "<C-w>=", opts("Make [W]indows [E]qual")) -- make split windows equal width & height
vim.keymap.set("n", "<leader>wq", ":close<CR>", opts("[W]indow [Q]uit")) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts("Go to upper window"))
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts("Go to lower window"))
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts("Go to left window"))
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts("Go to right window"))

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts("Indent left"))
vim.keymap.set("v", ">", ">gv", opts("Indent right"))

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts("Paste"))

vim.keymap.set("i", "jk", "<ESC>", opts("Exit INSERT MODE")) -- exit insert mode
vim.keymap.set("i", "kj", "<ESC>", opts("Exit INSERT MODE")) -- exit insert mode

-- Move text up and down
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==v", opts("Move line up"))
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", opts("Move line up"))
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==v", opts("Move line down"))
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", opts("Move line down"))

-- Comments
vim.keymap.set("i", "<C-/>", "<ESC>:Commentary<CR>", opts("Toggle comment"))
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
