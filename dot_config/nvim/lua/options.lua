-- Basic
vim.g.have_nerd_font = true
vim.o.number = true -- Line numbers (false)
vim.o.relativenumber = true -- Set relative numbered lines (false)
vim.o.cursorline = true -- Highlight current line (false)
vim.o.wrap = false -- Display lines as one long line (true)
vim.o.linebreak = true -- Companion to wrap, don't split words (false)
vim.o.scrolloff = 10 -- Keep n lines above/below cursor (0)
vim.o.sidescrolloff = 8 -- Keep n columns left/right of cursor (0)

-- Indentation
vim.o.tabstop = 4 -- Tab width (8)
vim.o.shiftwidth = 4 -- Indent width (8)
vim.o.softtabstop = 4 -- Number of spaces that tab counts (0)
vim.o.expandtab = true -- Spaces instead of tabs (false)
vim.o.smartindent = true -- Smart auto-indenting (false)
vim.o.autoindent = true -- Copy indent from current line (true)
vim.o.breakindent = true -- Keep wrapped line on same indent level (default: false)

-- Search
vim.o.ignorecase = true -- Case-insensitive search (false)
vim.o.smartcase = true -- Case sensitive if uppercase in search (false)
vim.o.hlsearch = false -- Highlight search results (true)
vim.o.incsearch = true -- Show matches as you type (false)

-- Visual
vim.o.termguicolors = true -- 24-bit colors (false)
vim.o.signcolumn = "yes" -- Show signcolumn ("auto")
vim.o.colorcolumn = "" -- Show column at "n" characters
vim.o.conceallevel = 0 -- Visual-control chars (**, '') in md etc. (0 - visible, 1-faded(def), 2-hidden, 3-idk)
vim.o.splitbelow = true -- Horizontal splits go below
vim.o.splitright = true -- Vertical splits go right

-- File Handling
vim.o.backup = false -- Creates a backup file (false)
vim.o.swapfile = false -- Creates a swapfile (true)
vim.o.undofile = true -- Save undo history (false)
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.o.updatetime = 250 -- Decrease update time (4000)
vim.o.encoding = "UTF-8" -- Set encoding
vim.opt.isfname:append "@-@" -- Allow @ for filenames
vim.o.confirm = true -- Ask when did not save on exit

-- Input
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end) -- Use system clipboard ('')
vim.o.timeoutlen = 200 -- Key timeout duration (500)
vim.o.ttimeoutlen = 10 -- Key code timeout
vim.o.mouse = "a" -- Enable mouse support (default: '')

-- Other
vim.o.spelllang = "ru_ru,en_us"
vim.o.spell = false
vim.o.inccommand = "split" -- Preview substitutions live, as you type!
vim.filetype.add {
  pattern = {
    [".*/.config/kitty/.*%.conf"] = "ini",
  },
}
-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH
