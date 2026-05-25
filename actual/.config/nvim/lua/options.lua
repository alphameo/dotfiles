-- General
vim.o.undofile = true -- Save undo history
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"

vim.o.backup = false -- Don't store backup while overwriting the file
vim.o.writebackup = false -- Don't store backup while overwriting the file
vim.o.swapfile = false -- Creates a swapfile

vim.o.updatetime = 250 -- Decrease update time
vim.o.lazyredraw = false -- Do not redraw during macros
vim.o.synmaxcol = 300 -- Syntax highlighting line limit
vim.o.redrawtime = 10000 -- Redraw tolerance
vim.o.maxmempattern = 20000 -- Max memory (KB)

vim.o.timeoutlen = 200 -- Key timeout duration
vim.o.ttimeoutlen = 10 -- Key code timeout

vim.o.autoread = true -- Autoread file changes outside nvim
vim.o.autowrite = false -- Autosave file after edit

vim.o.mouse = "a" -- Enable mouse support

vim.opt.clipboard:append "unnamedplus" -- Use system clipboard

vim.o.backspace = "indent,eol,start" -- Backspace behavior

vim.o.encoding = "utf-8"

vim.o.errorbells = false -- No error system sound

vim.o.confirm = true -- Ask when did not save on exit

vim.o.autochdir = false -- Autochange directories

vim.opt.isfname:append "@-@" -- Allow @ for filenames
vim.opt.iskeyword:append "-" -- Include "-" in-words

vim.opt.path:append "**" -- Include subdirs in :find

vim.o.selection = "exclusive" -- Select behavior last char

vim.o.hidden = true -- Allow hidden buffers
vim.o.modifiable = true -- Allow buffer modifications

vim.o.spelllang = "ru_ru,en_us" -- List for spellchecks
vim.o.spell = false -- Enable spellcheck

vim.opt.diffopt:append "linematch:60" -- Diff display options

vim.cmd "filetype plugin indent on" -- Load settings, mappings, indent per filetype

-- Editing
vim.o.tabstop = 4 -- Tab width
vim.o.shiftwidth = 4 -- Indent width
vim.o.softtabstop = 4 -- Number of spaces that tab counts
vim.o.expandtab = true -- Spaces instead of tabs
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true -- Copy indent from current line
vim.o.breakindent = true -- Keep wrapped line on same indent level

-- Completion
vim.o.autocomplete = false -- Enable default autocompletion
vim.o.completeopt = "menu,menuone,noselect,nearest,popup" -- Options of default completion
vim.o.wildmenu = false -- Cmd tab completion
vim.o.wildmode = "longest:full,full" -- Cmd completion behavior

-- Searching
vim.o.ignorecase = true -- Case-insensitive search
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true -- Case sensitive if uppercase in search
vim.o.hlsearch = true -- Highlight search results
vim.o.incsearch = true -- Show matches as you type
vim.o.showmatch = true -- Highlights matching brackets

-- Appearance
vim.o.termguicolors = true -- 24-bit colors

vim.o.cursorline = true -- Highlight current line

vim.o.number = true -- Line numbers
vim.o.relativenumber = true -- Set relative numbered lines
vim.o.signcolumn = "yes" -- Show column with help signs (e.g. breakpoints, warns)

vim.o.wrap = false -- Display lines as one long line
vim.o.linebreak = true -- Companion to wrap, don't split words
vim.o.foldenable = false -- Enable folding
vim.o.foldmethod = "expr" -- Use expression for folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.o.foldlevel = 99 -- Start with all opened folds

vim.o.scrolloff = 10 -- Keep n lines above/below cursor
vim.o.sidescrolloff = 8 -- Keep n columns left/right of cursor

vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitbelow = true -- Horizontal splits go below
vim.o.splitright = true -- Vertical splits go right

vim.opt.fillchars = { eob = " " } -- Character on emty lines at the end of buffer

vim.o.conceallevel = 0 -- Visual-control chars (**, '') in md etc.

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

vim.o.cmdheight = 0 -- Height of default command line
vim.o.showmode = true -- Show mode in default statusline

vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

vim.o.inccommand = "split" -- Preview :substitute options

-- Popup menu
vim.o.pumborder = "rounded" -- Popup menu border style
vim.o.pumheight = 10 -- Popup menu max heght
vim.o.pumwidth = 15 -- Popup menu min width
vim.o.pummaxwidth = 40 -- Popup menu max width
vim.o.pumblend = 0 -- Pupup menu transparency
vim.o.winblend = 0 -- Floating window transparency
vim.o.winborder = "none" -- Border of documentation, signature, completion

-- Custom filetypes
vim.filetype.add {
  extension = {
    axaml = "xml",
  },
}

require("vim._core.ui2").enable {
  enable = true,
  msg = {
    targets = "cmd",
    cmd = {
      height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
    },
    dialog = {
      height = 0.5, -- Maximum height.
    },
    msg = {
      height = 0.5, -- Maximum height.
      timeout = 2000, -- Time a message is visible in the message window.
    },
    pager = {
      height = 1,
    },
  },
}
