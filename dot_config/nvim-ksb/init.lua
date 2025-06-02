-- INFO: MAPPINGS
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior

map("n", "<C-q>", ":q <CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":q! <CR>", { silent = true, desc = "Force Quit" })

vim.keymap.set("x", "p", function()
	return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" }) -- exit insert mode

map("n", "<leader>aw", "<cmd> set wrap! <CR>", { silent = true, desc = "Toggle Line Wrap" })

-- INFO: OPTIONS
local opt = vim.opt
local o = vim.o

opt.tabstop = 4 -- Insert n spaces for a tab (default: 8)
opt.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
opt.shiftwidth = 4 -- The number of spaces inserted for each indentation (default: 8)
opt.expandtab = true -- Convert tabs to spaces (default: false)
opt.smartindent = true
opt.autoindent = true -- Copy indent from current line when starting new one (default: true)
opt.breakindent = true -- Enable break indent (default: false)

opt.wrap = false -- Display lines as one long line (default: true)
opt.linebreak = true -- Companion to wrap, don't split words (default: false)

opt.swapfile = false -- Creates a swapfile (default: true)
opt.backup = false -- Creates a backup file (default: false)
opt.undofile = true -- Save undo history (default: false)
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

opt.hlsearch = false -- Set highlight on search (default: true)
opt.incsearch = true
opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
opt.smartcase = true -- Smart case (default: false)

opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)

opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
opt.sidescrolloff = 8 -- Minimal number of screen columns either sideof cursor if wrap is `false` (default: 0)

opt.updatetime = 50 -- Decrease update time (default: 4000)
vim.opt.timeoutlen = 200 -- keypress delay
-- vim.opt.ttimeoutlen = 20 -- mode change delay

opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
opt.mouse = "a" -- Enable mouse mode (default: '')

o.showmode = false -- We don't need to see things like -- INSERT -- anymore. We have in lualine plugin (default: true)

-- INFO: PLUGIN MANAGER
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
