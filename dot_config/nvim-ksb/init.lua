-------------
-- OPTIONS --
-------------
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
vim.o.pumblend = 10 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10 -- Make popup menu smaller
-- vim.o.winblend = 10 -- Make floating windows slightly transparent (causes bugs with block cursor in overlays)

vim.o.listchars = "tab:> ,extends:…,precedes:…,nbsp:" -- Define which helper symbols to show
vim.o.list = false -- Show some helper symbols

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

--------------
-- MAPPINGS --
--------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Togglers
map("n", "\\l", ":setlocal cursorline! cursorline?<CR>", { silent = true, desc = "Toggle Location Line" })
map("n", "\\L", ":setlocal cursorcolumn! cursorcolumn?<CR>", { silent = true, desc = "Toggle Location Column" })
map("n", "\\g", ":setlocal list! list?<CR>", { silent = true, desc = "Toggle Glyphs" })
map("n", "\\n", ":setlocal relativenumber! relativenumber?<CR>", { silent = true, desc = "Toggle Relative Numbers" })
map("n", "\\s", ":setlocal spell! spell?<CR>", { silent = true, desc = "Toggle Spellcheck" })
map("n", "\\w", ":setlocal wrap! wrap?<CR>", { silent = true, desc = "Toggle Wrapping" })

-- Insert movements
map("c", "<M-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<M-l>", "<Right>", { silent = false, desc = "Right" })
map("i", "<M-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<M-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<M-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<M-l>", "<Right>", { noremap = false, desc = "Right" })
map("t", "<M-h>", "<Left>", { desc = "Left" })
map("t", "<M-j>", "<Down>", { desc = "Down" })
map("t", "<M-k>", "<Up>", { desc = "Up" })
map("t", "<M-l>", "<Right>", { desc = "Right" })

-- Escape Insert
map("i", "jj", "<ESC>", { desc = "Exit INSERT MODE" })

-- Files
map("n", "<C-s>", ":update<CR>", { silent = true, desc = "Save File" })
map("n", "<C-q>", ":quit<CR>", { silent = true, desc = "Quit" })

-- Buffers
map("n", "<M-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<M-Backspace>", "<C-^>", { silent = true, desc = "Switch to last buffer" })
map("n", "<M-]>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "<C-Tab>", ":bnext<CR>", { silent = true, desc = "Next Tab (buffer)" })
map("n", "<M-[>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })
map("n", "<C-S-Tab>", ":bprev<CR>", { silent = true, desc = "Previous Tab (buffer)" })

-- Windows
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-Left>", "<C-w>H", { desc = "Move Window to the Left" })
map("n", "<C-Right>", "<C-w>L", { desc = "Move Window to the Right" })
map("n", "<C-Down>", "<C-w>J", { desc = "Move Window to the Lower" })
map("n", "<C-Up>", "<C-w>K", { desc = "Move Window to the Upper" })

map("n", "<C-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<C-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<C-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<C-,>", "<C-w><", { desc = "Window Narower" })

-- Comments
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })

-- Terminals
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })
map("t", "<C-q>", "<C-\\><C-n>:quit<CR>", { silent = true, remap = true, desc = "Exit Terminal Mode" })

-- Text Movement
map("v", "<", "<gv", { desc = "Indent Left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent Right" }) -- stay in visual mode after indent

map("n", "<M-j>", ":m .+1<CR>==", { silent = true, desc = "Move Line Down" })
map("n", "<M-k>", ":m .-2<CR>==", { silent = true, desc = "Move Line Up" })
map("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })

-- Jumps
map("n", "[j", "<C-o>", { desc = "Jump Back" })
map("n", "]j", "<C-i>", { desc = "Jump Forward" })

-- Diffs
map("n", "<leader>DA", ":diffthis<CR>", { silent = true, desc = "Diff Add" })
map("n", "<leader>DR", ":diffoff<CR>", { silent = true, desc = "Diff Remove" })
map("n", "<leader>DO", ":diffoff!<CR>", { silent = true, desc = "Diff Off" })
map("n", "<leader>DU", ":diffupdate<CR>", { silent = true, desc = "Diff Update" })
map({ "n", "v" }, "<leader>DP", ":diffput<CR>", { silent = true, desc = "Diff Put" })
map({ "n", "v" }, "<leader>DG", ":diffget<CR>", { silent = true, desc = "Diff Get" })

-- Other Features
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("n", "<Left>", ':echo "Use h to move!"<CR>', { silent = true })
map("n", "<Right>", ':echo "Use l to move!"<CR>', { silent = true })
map("n", "<Up>", ':echo "Use k to move!"<CR>', { silent = true })
map("n", "<Down>", ':echo "Use j to move!"<CR>', { silent = true })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Russian Keybard
vim.opt.langmap = "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х\\[,Ъ\\],ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\;,Э\\'"
  .. ",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю\\>,йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х\\[,ъ\\],фa,ыs,вd,аf,пg,рh"
  .. ",оj,лk,дl,ж\\;,э\\',яz,чx,сc,мv,иb,тn,ьm,б\\<,ю\\>"
map("i", "оо", "<ESC>", { desc = "Exit INSERT MODE" })

--------------------
-- PLUGIN MANAGER --
--------------------
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
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
require("lazy").setup {
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
    require("kitty-scrollback").setup {
      {
        status_window = {
          autoclose = false,
          style_simple = false,
        },
        paste_window = {
          highlight_as_normal_win = true,
        },
      },
      ksb_builtin_get_text_all = {
        kitty_get_text = {
          ansi = true,
        },
      },
    }
  end,
}
