vim.wo.number = true -- Make line numbers default (default: false)
vim.opt.nu = true
vim.opt.relativenumber = true -- Set relative numbered lines (default: false)

vim.opt.tabstop = 2 -- Insert n spaces for a tab (default: 8)
vim.opt.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.opt.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
vim.opt.expandtab = true -- Convert tabs to spaces (default: false)

vim.opt.smartindent = true
vim.opt.autoindent = true -- Copy indent from current line when starting new one (default: true)
vim.opt.breakindent = true -- Enable break indent (default: false)

vim.opt.wrap = false -- Display lines as one long line (default: true)
vim.opt.linebreak = true -- Companion to wrap, don't split words (default: false)

vim.opt.swapfile = false -- Creates a swapfile (default: true)
vim.opt.backup = false -- Creates a backup file (default: false)
vim.opt.undofile = true -- Save undo history (default: false)
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"

vim.opt.hlsearch = false -- Set highlight on search (default: true)
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
vim.opt.smartcase = true -- Smart case (default: false)

vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)

vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns either sideof cursor if wrap is `false` (default: 0)
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default (default: 'auto')
vim.opt.isfname:append "@-@"

vim.opt.updatetime = 50 -- Decrease update time (default: 4000)

vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim. (default: '')
vim.opt.mouse = "a" -- Enable mouse mode (default: '')

vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore. We have in lualine plugin (default: true)
vim.opt.showtabline = 2 -- Always show tabs (default: 1)
vim.opt.conceallevel = 0 -- So that `` is visible in markdown files (default: 1)

vim.opt.pumheight = 10 -- Pop up menu height (default: 0)
