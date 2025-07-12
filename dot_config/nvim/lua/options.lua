local opt = vim.opt
local o = vim.o

-----------
-- BASIC --
-----------
opt.number = true -- Line numbers (false)
opt.relativenumber = true -- Set relative numbered lines (false)
opt.cursorline = true -- Highlight current line (false)
opt.cursorcolumn = false -- Highlight current column (false)
opt.wrap = false -- Display lines as one long line (true)
opt.linebreak = true -- Companion to wrap, don't split words (false)
opt.scrolloff = 10 -- Keep n lines above/below cursor (0)
opt.sidescrolloff = 8 -- Keep n columns left/right of cursor (0)

-----------------
-- INDENTATION --
-----------------
opt.tabstop = 4 -- Tab width (8)
opt.shiftwidth = 4 -- Indent width (8)
opt.softtabstop = 4 -- Number of spaces that tab counts (0)
opt.expandtab = true -- Spaces instead of tabs (false)
opt.smartindent = true -- Smart auto-indenting (false)
opt.autoindent = true -- Copy indent from current line (true)
opt.breakindent = true -- Keep wrapped line on same indent level (default: false)

------------
-- SEARCH --
------------
opt.ignorecase = true -- Case-insensitive search (false)
opt.smartcase = true -- Case sensitive if uppercase in search (false)
opt.hlsearch = false -- Highlight search results (true)
opt.incsearch = true -- Show matches as you type (false)

------------
-- VISUAL --
------------
opt.termguicolors = true -- 24-bit colors (false)
opt.signcolumn = "yes" -- Show signcolumn ("auto")
opt.colorcolumn = "" -- Show column at "n" characters
opt.conceallevel = 0 -- Visual-control chars (**, '') in md etc. (0 - visible, 1-faded(def), 2-hidden, 3-idk)

-------------------
-- FILE HANDLING --
-------------------
opt.backup = false -- Creates a backup file (false)
opt.swapfile = false -- Creates a swapfile (true)
opt.undofile = true -- Save undo history (false)
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.updatetime = 300 -- Decrease update time (4000)
opt.autoread = true -- Auto reload files changed outside vim (false)
opt.autowrite = false -- Don't auto save (false)
opt.encoding = "UTF-8" -- Set encoding
opt.isfname:append "@-@" -- Allow @ for filenames

-----------
-- INPUT --
-----------
opt.clipboard:append "unnamedplus" -- Use system clipboard ('')
opt.timeoutlen = 200 -- Key timeout duration (500)
opt.ttimeoutlen = 0 -- Key code timeout
opt.mouse = "a" -- Enable mouse support (default: '')

-----------
-- SPELL --
-----------
o.spelllang = "ru_ru,en_us"
o.spell = false

-----------
-- SPLIT --
-----------
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right

-----------
-- OTHER --
-----------
vim.filetype.add {
  pattern = {
    [".*/.config/hypr/.*%.conf"] = "hyprlang",
    [".*/.config/waybar/.*%.css"] = "gtkcss",
    [".*/.config/rofi/.*%.css"] = "gtkcss",
    [".*/.config/kitty/.*%.conf"] = "kitty",
  },
}
