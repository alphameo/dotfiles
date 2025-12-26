-- General
vim.o.undofile = true -- Save undo history
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"

vim.o.backup = false -- Don't store backup while overwriting the file
vim.o.writebackup = false -- Don't store backup while overwriting the file

vim.o.mouse = "a" -- Enable mouse support

vim.schedule(function()
  vim.o.clipboard = "unnamedplus" -- Use system clipboard
end)

vim.o.timeoutlen = 200 -- Key timeout duration
vim.o.ttimeoutlen = 10 -- Key code timeout

vim.o.confirm = true -- Ask when did not save on exit

vim.o.swapfile = false -- Creates a swapfile
vim.o.updatetime = 250 -- Decrease update time
vim.opt.isfname:append "@-@" -- Allow @ for filenames

vim.o.spelllang = "ru_ru,en_us" -- List for spellchecks
vim.o.spell = false -- Enable spellcheck

vim.cmd "filetype plugin indent on" -- Load settings, mappings, indent per filetype

-- Appearance
vim.o.tabstop = 4 -- Tab width
vim.o.shiftwidth = 4 -- Indent width
vim.o.softtabstop = 4 -- Number of spaces that tab counts
vim.o.expandtab = true -- Spaces instead of tabs
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true -- Copy indent from current line
vim.o.breakindent = true -- Keep wrapped line on same indent level

vim.o.cursorline = true -- Highlight current line

vim.o.wrap = false -- Display lines as one long line
vim.o.linebreak = true -- Companion to wrap, don't split words

vim.o.number = true -- Line numbers
vim.o.relativenumber = true -- Set relative numbered lines

vim.o.scrolloff = 10 -- Keep n lines above/below cursor
vim.o.sidescrolloff = 8 -- Keep n columns left/right of cursor

vim.o.splitbelow = true -- Horizontal splits go below
vim.o.splitright = true -- Vertical splits go right

vim.o.signcolumn = "yes" -- Show signcolumn
vim.o.fillchars = "eob: " -- Don't show `~` outside of buffer

vim.o.termguicolors = true -- 24-bit colors

vim.o.conceallevel = 0 -- Visual-control chars (**, '') in md etc.

vim.o.colorcolumn = "" -- Show column at "n" character

vim.opt.shortmess:append "WcC" -- Reduce command line messages

vim.o.splitkeep = "screen" -- Reduce scroll during window split

vim.o.foldenable = false

-- Extra UI
vim.o.showcmd = true -- show keystrokes in default command line (noice uses it too)
vim.o.cmdheight = 0 -- height of default command line
vim.o.showmode = false -- show mode in default command line

vim.o.pumblend = 10 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10 -- Make popup menu smaller
-- vim.o.winblend = 10 -- Make floating windows slightly transparent (causes bugs with block cursor in overlays)

vim.opt.showbreak = "↳"
local space = "·"
vim.opt.listchars = {
  multispace = space,
  lead = space,
  trail = space,
  nbsp = space,
  eol = "⏎",
  tab = "› ",
  extends = "…",
  precedes = "…",
}
vim.opt.list = false -- Show non-printing characters (glyphs)

if vim.fn.exists "syntax_on" ~= 1 then
  vim.cmd "syntax enable" -- Enable syntax highlighting
end

vim.o.winborder = "none" -- Border of documentation, signature, completion

-- Editing
vim.o.ignorecase = true -- Case-insensitive search
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true -- Case sensitive if uppercase in search
vim.o.hlsearch = true -- Highlight search results
vim.o.incsearch = true -- Show matches as you type

vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

vim.o.inccommand = "split" -- Preview :substitute options

-- Binaries
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
