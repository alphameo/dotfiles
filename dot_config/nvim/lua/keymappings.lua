vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Togglers
map("n", "\\l", ":setlocal cursorline! cursorline?<CR>", { silent = true, desc = "Toggle Location Line" })
map("n", "\\L", ":setlocal cursorcolumn! cursorcolumn?<CR>", { silent = true, desc = "Toggle Location Column" })
map("n", "\\g", ":setlocal list! list?<CR>", { silent = true, desc = "Toggle Glyphs" })
map("n", "\\n", ":setlocal relativenumber! relativenumber?<CR>", { silent = true, desc = "Toggle Relative Numbers" })
map("n", "\\s", ":setlocal spell! spell?<CR>", { silent = true, desc = "Toggle Spellcheck" })
map("n", "\\w", ":setlocal wrap! wrap?<CR>", { silent = true, desc = "Toggle Wrapping" })

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

-- Files
map("n", "<C-s>", ":update<CR>", { silent = true, desc = "Save File" })
map("n", "<C-S-s>", ":wall<CR>", { silent = true, desc = "Save All Files" })
map("n", "<C-q>", ":quit<CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":quit!<CR>", { silent = true, desc = "Force Quit" })

-- Buffers
map("n", "<M-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer

-- Windows
map("n", "<C-S-\\>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<C-\\>", "<C-w>v", { desc = "Window Vertical Split" })

map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-Left>", "<C-w>H", { desc = "Move Window to the Left" })
map("n", "<C-Right>", "<C-w>L", { desc = "Move Window to the Right" })
map("n", "<C-Down>", "<C-w>J", { desc = "Move Window to the Lower" })
map("n", "<C-Up>", "<C-w>K", { desc = "Move Window to the Upper" })

map("n", "<C-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<C-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<C-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<C-,>", "<C-w><", { desc = "Window Narower" })

-- Comments
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
map({ "n", "v" }, "gc", "gc", { remap = true, desc = "Toggle comment" })

-- Terminals
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })
map("t", "<C-q>", "<C-\\><C-n>:quit<CR>", { silent = true, remap = true, desc = "Exit Terminal Mode" })

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

-- Other Features
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("n", "<Left>", ':echo "Use h to move!"<CR>', { silent = true })
map("n", "<Right>", ':echo "Use l to move!"<CR>', { silent = true })
map("n", "<Up>", ':echo "Use k to move!"<CR>', { silent = true })
map("n", "<Down>", ':echo "Use j to move!"<CR>', { silent = true })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Russian Keybard
vim.opt.langmap = "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х\\[,Ъ\\],ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\;,Э\\'"
  .. ",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю\\>,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х\\[,ъ\\],фa,ыs,вd,аf,пg,рh"
  .. ",оj,лk,дl,ж\\;,э\\',яz,чx,сc,мv,иb,тn,ьm,б\\<,ю\\>"
map("i", "оо", "<ESC>", { desc = "Exit INSERT MODE" })
