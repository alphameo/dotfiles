-------------
-- OPTIONS --
-------------
local opt = vim.opt
-- Basic
opt.number = true -- Line numbers (false)
opt.relativenumber = true -- Set relative numbered lines (false)
opt.cursorline = true -- Highlight current line (false)
opt.wrap = false -- Display lines as one long line (true)
opt.linebreak = true -- Companion to wrap, don't split words (false)
opt.scrolloff = 10 -- Keep n lines above/below cursor (0)
opt.sidescrolloff = 8 -- Keep n columns left/right of cursor (0)
-- Indentation
opt.tabstop = 4 -- Tab width (8)
opt.shiftwidth = 4 -- Indent width (8)
opt.softtabstop = 4 -- Number of spaces that tab counts (0)
opt.expandtab = true -- Spaces instead of tabs (false)
opt.smartindent = true -- Smart auto-indenting (false)
opt.autoindent = true -- Copy indent from current line (true)
opt.breakindent = true -- Keep wrapped line on same indent level (default: false)
-- Search
opt.ignorecase = true -- Case-insensitive search (false)
opt.smartcase = true -- Case sensitive if uppercase in search (false)
opt.hlsearch = false -- Highlight search results (true)
opt.incsearch = true -- Show matches as you type (false)
-- Visual
opt.termguicolors = true -- 24-bit colors (false)
opt.signcolumn = "yes" -- Show signcolumn ("auto")
opt.colorcolumn = "" -- Show column at "n" characters
opt.conceallevel = 0 -- Visual-control chars (**, '') in md etc. (0 - visible, 1-faded(def), 2-hidden, 3-idk)
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
-- File Handling
opt.backup = false -- Creates a backup file (false)
opt.swapfile = false -- Creates a swapfile (true)
opt.undofile = true -- Save undo history (false)
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.updatetime = 300 -- Decrease update time (4000)
opt.encoding = "UTF-8" -- Set encoding
opt.isfname:append("@-@") -- Allow @ for filenames
-- Input
opt.clipboard:append("unnamedplus") -- Use system clipboard ('')
opt.timeoutlen = 200 -- Key timeout duration (500)
opt.ttimeoutlen = 10 -- Key code timeout
opt.mouse = "a" -- Enable mouse support (default: '')
-- Other
opt.spelllang = "ru_ru,en_us"
opt.spell = false
vim.filetype.add({
	pattern = {
		[".*/.config/hypr/.*%.conf"] = "hyprlang",
		[".*/.config/waybar/.*%.css"] = "gtkcss",
		[".*/.config/rofi/.*%.css"] = "gtkcss",
		[".*/.config/kitty/.*%.conf"] = "kitty",
	},
})

--------------
-- MAPPINGS --
--------------
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
map("n", "<C-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<C-x>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" }) -- close buffer

-- Windows
map("n", "<C-S-\\>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<C-\\>", "<C-w>v", { desc = "Window Vertical Split" })

map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

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

--------------------
-- PLUGIN MANAGER --
--------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-------------
-- PLUGINS --
-------------
require("lazy").setup({
	"mikesmithgh/kitty-scrollback.nvim",
	enabled = true,
	lazy = true,
	cmd = {
		"KittyScrollbackGenerateKittens",
		"KittyScrollbackCheckHealth",
		"KittyScrollbackGenerateCommandLineEditing",
	},
	event = { "User KittyScrollbackLaunch" },
	config = function()
		require("kitty-scrollback").setup({})
	end,
})
