vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- File
map("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save File" })
map("n", "<C-S-s>", ":wall<CR>", { silent = true, desc = "Save All Files" })
map("n", "<C-q>", ":q<CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":q!<CR>", { silent = true, desc = "Force Quit" })

-- Appearance
map("n", "<leader>aw", ":set wrap!<CR>", { silent = true, desc = "Toggle Line Wrap" })

-- Buffers
map("n", "<A-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<A-w>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" }) -- close buffer

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
map("n", "<left>", ':echo "Use h to move!"<CR>', { silent = true })
map("n", "<right>", ':echo "Use l to move!"<CR>', { silent = true })
map("n", "<up>", ':echo "Use k to move!"<CR>', { silent = true })
map("n", "<down>", ':echo "Use j to move!"<CR>', { silent = true })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

map("v", "<", "<gv", { desc = "Indent Left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent Right" }) -- stay in visual mode after indent

map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move Line Down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Page Down" }) -- center after scroll down
map("n", "<C-u>", "<C-u>zz", { desc = "Page Up" }) -- center after scroll up
map("n", "n", "nzzzv", { desc = "Next Occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous Occurance" }) -- center after find

map("n", "<C-e>", "5<C-e>", { desc = "Scroll Down" }) -- faster scroll without cursor
map("n", "<C-y>", "5<C-y>", { desc = "Scroll Up" }) -- faster scroll without cursor

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
