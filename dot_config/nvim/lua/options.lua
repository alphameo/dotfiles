local opt = vim.opt
local o = vim.o
local g = vim.g

o.number = true -- Make line numbers default (default: false)
opt.nu = true
opt.relativenumber = true -- Set relative numbered lines (default: false)

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
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"

opt.hlsearch = false -- Set highlight on search (default: true)
opt.incsearch = true
opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
opt.smartcase = true -- Smart case (default: false)

opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)

opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
opt.sidescrolloff = 8 -- Minimal number of screen columns either sideof cursor if wrap is `false` (default: 0)
opt.signcolumn = "yes" -- Keep signcolumn on by default (default: 'auto')
opt.isfname:append "@-@"

opt.updatetime = 50 -- Decrease update time (default: 4000)
vim.opt.timeoutlen = 200 -- keypress delay
-- vim.opt.ttimeoutlen = 20 -- mode change delay

opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
opt.mouse = "a" -- Enable mouse mode (default: '')

o.showmode = false -- We don't need to see things like -- INSERT -- anymore. We have in lualine plugin (default: true)
opt.showtabline = 2 -- Always show tabs (default: 1)
opt.conceallevel = 2 -- Visual-control chars (**, '') in md etc. (0 - visible, 1-faded(def), 2-hidden, 3-idk)

opt.pumheight = 10 -- Pop up menu height (default: 0)

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

o.spelllang = "ru_ru,en_us"

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
