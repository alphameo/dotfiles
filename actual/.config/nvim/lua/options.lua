-- General
vim.loader.enable()

vim.g.have_nerd_font = true

vim.o.undofile = true
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.o.updatetime = 250
vim.o.lazyredraw = false
vim.o.synmaxcol = 300
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000

vim.o.timeoutlen = 200
vim.o.ttimeoutlen = 10

vim.o.autoread = true
vim.o.autowrite = false

vim.o.mouse = "a"

vim.opt.clipboard:append "unnamedplus" -- Use system clipboard

vim.o.backspace = "indent,eol,start"

vim.o.encoding = "utf-8"

vim.o.errorbells = false

vim.o.confirm = true

vim.o.autochdir = false

vim.o.selection = "exclusive"

vim.o.hidden = true
vim.o.modifiable = true

vim.o.spelllang = "ru_ru,en_us"
vim.o.spell = false

vim.opt.diffopt:append "linematch:60" -- Diff display options

vim.cmd "filetype plugin indent on" -- Load settings, mappings, indent per filetype

-- Editing
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true

-- Completion
vim.o.autocomplete = false
vim.o.completeopt = "menuone,popup,noselect,noinsert,fuzzy"
vim.o.complete = "o,w,b,u"
vim.o.wildmenu = false
vim.o.wildmode = "noselect:full"
vim.o.wildoptions = "pum,fuzzy,tagfile"

-- Searching
vim.o.ignorecase = true
vim.o.infercase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.showmatch = true

-- Appearance
vim.o.termguicolors = true

vim.o.cursorline = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

vim.o.wrap = false
vim.o.linebreak = true
vim.o.foldenable = false
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99 -- Start with all opened folds

vim.o.scrolloff = 10
vim.o.sidescrolloff = 4

vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.fillchars = { eob = " " } -- Character on emty lines at the end of buffer

vim.o.conceallevel = 0

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

vim.o.cmdheight = 0
vim.o.showmode = true
vim.o.ruler = true
vim.o.laststatus = 3

vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

vim.o.inccommand = "split" -- Preview :substitute options

-- Popup menu
vim.o.pumborder = "rounded"
vim.o.pumheight = 10
vim.o.pumwidth = 15
vim.o.pummaxwidth = 0
vim.o.pumblend = 0
vim.o.winblend = 0
vim.o.winborder = "none"

-- Custom filetypes
vim.filetype.add {
  extension = {
    axaml = "xml",
  },
}

-- Finders
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"

local ignore_patterns = {
  "node_modules",
  "%.git",
  "%.cache",
  "dist",
  "build",
  "%.tmp",
  "%.log",
}
function _G.native_find(text, _)
  local files = vim.fn.glob("**/*", true, true)
  local result = {}
  for _, f in ipairs(files) do
    if vim.fn.isdirectory(f) == 0 then
      local skip = false
      for _, pat in ipairs(ignore_patterns) do
        if f:match(pat) then
          skip = true
          break
        end
      end
      if not skip then
        result[#result + 1] = f
      end
    end
  end
  return vim.fn.matchfuzzy(result, text)
end
vim.opt.findfunc = "v:lua.native_find"

-- Netrw
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_banner = 0 -- hide the top banner
vim.g.netrw_winsize = 25 -- fix the left split width
vim.g.netrw_browse_split = 0 -- open files in the previous window
vim.g.netrw_altfile = 1 -- keep the alternate file correct

-- UI2
require("vim._core.ui2").enable {
  enable = true,
  msg = {
    targets = "msg", -- "cmd" or "msg"
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
