vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Custom
local toggle = require "custom.toggle"
map("n", "\\s", toggle.spell, { silent = true, desc = "Toggle Spellcheck Locally" })
map("n", "\\w", toggle.wrap, { silent = true, desc = "Toggle Wrapping Locally" })
map("n", "\\d", toggle.diagnostics, { silent = true, desc = "Toggle Diagnostics" })
map("n", "\\l", toggle.colorcolumn, { silent = true, desc = "Toggle Limit Column" })
map("n", "\\<Tab>", toggle.expandtab, { silent = true, desc = "Toggle Expandtab Locally" })

-- Terminals
local term = require "custom.terminal"
map("n", "<leader>ts", term.toggle_split_terminal, { silent = true, desc = "Terminal Split" })
map("n", "<C-`>", term.toggle_split_terminal, { silent = true, desc = "Terminal Split" })
map("t", "<leader>ts", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<C-`>", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })

map("n", "<leader>tf", term.toggle_float_terminal, { silent = true, desc = "Terminal Floating" })
map("n", "<C-S-`>", term.toggle_float_terminal, { silent = true, desc = "Terminal Floating" })
map("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<C-S-`>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })

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
map("n", "<M-]>", ":bnext<CR>", { silent = true, desc = "Next Buffer" })
map("n", "<M-[>", ":bprev<CR>", { silent = true, desc = "Previous Buffer" })
map("n", "<M-Backspace>", "<C-^>", { silent = true, desc = "Switch to last buffer" })
map("n", "<M-w>", ":bdelete<CR>", { silent = true, desc = "Next Buffer" })

map("n", "]b", ":bnext<CR>", { silent = true, desc = "Next Buffer" })
map("n", "[b", ":bprev<CR>", { silent = true, desc = "Previous Buffer" })
map("n", "<C-n>", ":bnext<CR>", { silent = true, desc = "Next Buffer" })
map("n", "<C-p>", ":bprev<CR>", { silent = true, desc = "Previous Buffer" })
map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next Buffer" })
map("n", "<C-S-Tab>", ":bprev<CR>", { silent = true, desc = "Previous Buffer" })

map("n", "]T", ":tabnext<CR>", { silent = true, desc = "Next Tab" })
map("n", "[T", ":tabprev<CR>", { silent = true, desc = "Previous Tab" })

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

map("n", "<leader>fd", function()
  vim.diagnostic.setqflist()
  vim.cmd "copen"
end, { silent = true, desc = "Find in document Diagnostics" })

-- Formatting
map("n", "gq", vim.lsp.formatexpr, { desc = "Formatexpr" })

-- Finders
map("n", "<leader>ff", ":find ", { silent = false, desc = "Find Files" })

map("n", "<leader>fg", function()
  vim.ui.input({ prompt = "Grep: " }, function(pattern)
    if pattern then
      vim.cmd("silent grep! " .. vim.fn.fnameescape(pattern))
      vim.cmd "copen"
    end
  end)
end, { silent = true })

-- Completion
map("i", "<C-Space>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-e>"
  else
    -- vim.lsp.completion.get()
    -- return ""
    return "<C-x><C-o>"
  end
end, { expr = true, desc = "Toggle Completion" })

map("i", "<C-j>", function()
  if vim.fn.pumvisible() == 1 then
    return "<Down>"
  else
    return "<C-j>"
  end
end, { expr = true, desc = "Next Completion" })

map("i", "<C-k>", function()
  if vim.fn.pumvisible() == 1 then
    return "<Up>"
  else
    return "<C-k>"
  end
end, { expr = true, desc = "Previous Completion" })

map("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  else
    return "<Tab>"
  end
end, { expr = true, desc = "Accept Completion" })

-- Vim Pack
map({ "n" }, "<leader>pu", vim.pack.update, { silent = true, desc = "vim.pack.update" })

-- Other Features
vim.keymap.set("n", "<leader>e", ":Lexplore<cr>", { silent = true, desc = "File Tree" })
map("n", "<leader>E", ":Explore<CR>", { silent = true, desc = "Explorer" })
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("n", "<leader>nn", ":messages<CR>", { silent = true, desc = "Notifications List" })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

map("n", "<leader>..", function()
  vim.cmd "e $MYVIMRC | cd %:p:h"
  vim.notify("Current working directory: " .. vim.fn.getcwd())
end, { silent = true, desc = "Open nvim config" })
