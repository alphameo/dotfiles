local o = vim.opt
local g = vim.g
local opt = vim.opt

-- Basic
g.have_nerd_font = true
o.number = true -- Line numbers (false)
o.relativenumber = true -- Set relative numbered lines (false)
o.cursorline = true -- Highlight current line (false)
o.wrap = false -- Display lines as one long line (true)
o.linebreak = true -- Companion to wrap, don't split words (false)
o.scrolloff = 10 -- Keep n lines above/below cursor (0)
o.sidescrolloff = 8 -- Keep n columns left/right of cursor (0)

-- Indentation
o.tabstop = 4 -- Tab width (8)
o.shiftwidth = 4 -- Indent width (8)
o.softtabstop = 4 -- Number of spaces that tab counts (0)
o.expandtab = true -- Spaces instead of tabs (false)
o.smartindent = true -- Smart auto-indenting (false)
o.autoindent = true -- Copy indent from current line (true)
o.breakindent = true -- Keep wrapped line on same indent level (default: false)

-- Search
o.ignorecase = true -- Case-insensitive search (false)
o.smartcase = true -- Case sensitive if uppercase in search (false)
o.hlsearch = false -- Highlight search results (true)
o.incsearch = true -- Show matches as you type (false)

-- Visual
o.termguicolors = true -- 24-bit colors (false)
o.signcolumn = "yes" -- Show signcolumn ("auto")
o.colorcolumn = "" -- Show column at "n" characters
o.conceallevel = 0 -- Visual-control chars (**, '') in md etc. (0 - visible, 1-faded(def), 2-hidden, 3-idk)
o.splitbelow = true -- Horizontal splits go below
o.splitright = true -- Vertical splits go right

-- File Handling
o.backup = false -- Creates a backup file (false)
o.swapfile = false -- Creates a swapfile (true)
o.undofile = true -- Save undo history (false)
o.undodir = os.getenv "HOME" .. "/.vim/undodir"
o.updatetime = 250 -- Decrease update time (4000)
o.encoding = "UTF-8" -- Set encoding
opt.isfname:append "@-@" -- Allow @ for filenames
o.confirm = true

-- Input
vim.schedule(function()
  o.clipboard = "unnamedplus"
end) -- Use system clipboard ('')
o.timeoutlen = 200 -- Key timeout duration (500)
o.ttimeoutlen = 10 -- Key code timeout
o.mouse = "a" -- Enable mouse support (default: '')

-- Other
o.spelllang = "ru_ru,en_us"
o.spell = false
o.inccommand = "split" -- Preview substitutions live, as you type!
vim.filetype.add {
  pattern = {
    [".*/.config/hypr/.*%.conf"] = "hyprlang",
    [".*/.config/waybar/.*%.css"] = "gtkcss",
    [".*/.config/rofi/.*%.css"] = "gtkcss",
    [".*/.config/kitty/.*%.conf"] = "kitty",
  },
}
