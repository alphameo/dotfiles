vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Togglers
map("n", "\\c", ":setlocal cursorline! cursorline?<CR>", { silent = true, desc = "Toggle 'cursorline'" })
map("n", "\\C", ":setlocal cursorcolumn! cursorcolumn?<CR>", { silent = true, desc = "Toggle 'cursorcolumn'" })
map("n", "\\l", ":setlocal list! list?<CR>", { silent = true, desc = "Toggle 'list'" })
map("n", "\\n", ":setlocal relativenumber! relativenumber?<CR>", { silent = true, desc = "Toggle 'relativenumber'" })
map("n", "\\s", ":setlocal spell! spell?<CR>", { silent = true, desc = "Toggle 'spell'" })
map("n", "\\w", ":setlocal wrap! wrap?<CR>", { silent = true, desc = "Toggle 'wrap'" })

-- Insert movements
map("c", "<A-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<A-l>", "<Right>", { silent = false, desc = "Right" })
map("i", "<A-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<A-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<A-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<A-l>", "<Right>", { noremap = false, desc = "Right" })

map("t", "<A-h>", "<Left>", { desc = "Left" })
map("t", "<A-j>", "<Down>", { desc = "Down" })
map("t", "<A-k>", "<Up>", { desc = "Up" })
map("t", "<A-l>", "<Right>", { desc = "Right" })

-- File
map("n", "<C-s>", ":update<CR>", { silent = true, desc = "Save File" })
map("n", "<C-S-s>", ":wall<CR>", { silent = true, desc = "Save All Files" })
map("n", "<C-q>", ":quit<CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":quit!<CR>", { silent = true, desc = "Force Quit" })

-- Buffers
map("n", "<A-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer

-- Windows
map("n", "<C-S-\\>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<C-\\>", "<C-w>v", { desc = "Window Vertical Split" })

map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-left>", "<C-w>H", { desc = "Move Window to the Left" })
map("n", "<C-right>", "<C-w>L", { desc = "Move Window to the Right" })
map("n", "<C-down>", "<C-w>J", { desc = "Move Window to the Lower" })
map("n", "<C-up>", "<C-w>K", { desc = "Move Window to the Upper" })

map("n", "<C-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<C-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<C-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<C-,>", "<C-w><", { desc = "Window Narower" })

-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { silent = true, desc = "Toggle Comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })

-- Features
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("n", "<Left>", ':echo "Use h to move!"<CR>', { silent = true })
map("n", "<Right>", ':echo "Use l to move!"<CR>', { silent = true })
map("n", "<Up>", ':echo "Use k to move!"<CR>', { silent = true })
map("n", "<Down>", ':echo "Use j to move!"<CR>', { silent = true })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

map("v", "<", "<gv", { desc = "Indent Left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent Right" }) -- stay in visual mode after indent

map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move Line Down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })

map("n", "n", "nzzzv", { desc = "Next Occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous Occurance" }) -- center after find

map("n", "gb", "<C-o>", { desc = "Go Back" })

vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true }) -- paste without yanking

map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "jj", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" })

vim.opt.langmap = "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х\\[,Ъ\\],ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\;,Э\\',ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю\\>"
  .. ",йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х\\[,ъ\\],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э\\',яz,чx,сc,мv,иb,тn,ьm,б\\<,ю\\>"
map("i", "ол", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "оо", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "ло", "<ESC>", { desc = "Exit INSERT MODE" })
