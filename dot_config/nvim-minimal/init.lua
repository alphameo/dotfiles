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

-- Extra UI
vim.o.pumblend = 10 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.winblend = 10 -- Make floating windows slightly transparent

vim.o.listchars = "tab:> ,extends:…,precedes:…,nbsp:␣" -- Define which helper symbols to show
vim.o.list = false -- Show some helper symbols

if vim.fn.exists "syntax_on" ~= 1 then
  vim.cmd "syntax enable" -- Enable syntax highlighting
end

vim.o.winborder = "none" -- Border of documentation, signature, completion

-- Editing
vim.o.ignorecase = true -- Case-insensitive search
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.smartcase = true -- Case sensitive if uppercase in search
vim.o.hlsearch = false -- Highlight search results
vim.o.incsearch = true -- Show matches as you type

vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

vim.o.inccommand = "split" -- Preview :substitute options

--------------
-- MAPPINGS --
--------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Togglers
map("n", "\\c", ":setlocal cursorline! cursorline?<CR>", { silent = true, desc = "Toggle 'cursorline'" })
map("n", "\\C", ":setlocal cursorcolumn! cursorcolumn?<CR>", { silent = true, desc = "Toggle 'cursorcolumn'" })
map("n", "\\l", ":setlocal list! list?<CR>", { silent = true, desc = "Toggle 'list'" })
map("n", "\\n", ":setlocal relativenumber! relativenumber?<CR>", { silent = true, desc = "Toggle 'relativenumber'" })
map("n", "\\s", ":setlocal spell! spell?<CR>", { silent = true, desc = "Toggle 'spell'" })
map("n", "\\w", ":setlocal wrap! wrap?<CR>", { silent = true, desc = "Toggle 'wrap'" })

-- Insert movements
map("c", "<A-h>", "<Left>", { silent = false, desc = "Left" })
map("c", "<A-l>", "<Right>", { silent = false, desc = "Right" })
map("i", "<A-h>", "<Left>", { noremap = false, desc = "Left" })
map("i", "<A-j>", "<Down>", { noremap = false, desc = "Down" })
map("i", "<A-k>", "<Up>", { noremap = false, desc = "Up" })
map("i", "<A-l>", "<Right>", { noremap = false, desc = "Right" })
map("t", "<A-h>", "<Left>", { desc = "Left" })
map("t", "<A-j>", "<Down>", { desc = "Down" })
map("t", "<A-k>", "<Up>", { desc = "Up" })
map("t", "<A-l>", "<Right>", { desc = "Right" })

-- Escape Insert
map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "jj", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" })

-- Files
map("n", "<C-s>", ":update<CR>", { silent = true, desc = "Save File" })
map("n", "<C-S-s>", ":wall<CR>", { silent = true, desc = "Save All Files" })
map("n", "<C-q>", ":quit<CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":quit!<CR>", { silent = true, desc = "Force Quit" })

-- Buffers
map("n", "<A-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer

-- Windows
map("n", "<C-S-\\>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<C-\\>", "<C-w>v", { desc = "Window Vertical Split" })

map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-left>", "<C-w>H", { desc = "Move Window to the Left" })
map("n", "<C-right>", "<C-w>L", { desc = "Move Window to the Right" })
map("n", "<C-down>", "<C-w>J", { desc = "Move Window to the Lower" })
map("n", "<C-up>", "<C-w>K", { desc = "Move Window to the Upper" })

map("n", "<C-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<C-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<C-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<C-,>", "<C-w><", { desc = "Window Narower" })

-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { silent = true, desc = "Toggle Comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })

-- Terminals
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })
map("t", "<C-q>", "<C-\\><C-n>:quit<CR>", { silent = true, remap = true, desc = "Exit Terminal Mode" })

-- Text Movement
map("v", "<", "<gv", { desc = "Indent Left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent Right" }) -- stay in visual mode after indent

map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move Line Down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })

-- Jumps
map("n", "[j", "<C-o>", { desc = "Jump Back" })
map("n", "]j", "<C-i>", { desc = "Jump Forward" })

-- Other Features
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("n", "<Left>", ':echo "Use h to move!"<CR>', { silent = true })
map("n", "<Right>", ':echo "Use l to move!"<CR>', { silent = true })
map("n", "<Up>", ':echo "Use k to move!"<CR>', { silent = true })
map("n", "<Down>", ':echo "Use j to move!"<CR>', { silent = true })

map("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

map("n", "n", "nzzzv", { desc = "Next Occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous Occurance" }) -- center after find

vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true }) -- paste without yanking

-- Russian Keybard
vim.opt.langmap = "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х\\[,Ъ\\],ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\;,Э\\',ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б\\<,Ю\\>"
  .. ",йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х\\[,ъ\\],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э\\',яz,чx,сc,мv,иb,тn,ьm,б\\<,ю\\>"
map("i", "ол", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "оо", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "ло", "<ESC>", { desc = "Exit INSERT MODE" })

-------------
-- USRCMDS --
-------------
local win_state = {
  buf = -1,
  win = -1,
}

local toggle_terminal = function(create_win_func)
  if not vim.api.nvim_win_is_valid(win_state.win) or not vim.api.nvim_buf_is_valid(win_state.buf) then
    win_state = create_win_func { buf = win_state.buf }
    if vim.bo[win_state.buf].buftype ~= "terminal" then
      vim.api.nvim_call_function("termopen", { vim.o.shell })
    end
    vim.cmd "startinsert"
  else
    vim.api.nvim_win_hide(win_state.win)
    vim.cmd "stopinsert"
  end
end

local new_hidden_win_state = function(opts, win_config)
  local buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = "hide"
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Split Terminal
local create_split_buffer = function(opts)
  opts = opts or {}

  local win_config = {
    vertical = false,
    split = "below",
    height = 15,
    style = "minimal",
  }

  return new_hidden_win_state(opts, win_config)
end

local toggle_split_terminal = function()
  toggle_terminal(create_split_buffer)
end

vim.api.nvim_create_user_command("ToggleSplitTerm", toggle_split_terminal, {})

vim.keymap.set("n", "<leader>ts", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
vim.keymap.set("n", "<C-`>", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
vim.keymap.set("t", "<leader>ts", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
vim.keymap.set("t", "<C-`>", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })

-- Float Terminal
local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  return new_hidden_win_state(opts, win_config)
end

local toggle_float_terminal = function()
  toggle_terminal(create_floating_window)
end

vim.api.nvim_create_user_command("ToggleFloatTerm", toggle_float_terminal, {})

vim.keymap.set("n", "<leader>tf", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
vim.keymap.set("n", "<C-S-`>", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
vim.keymap.set("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
vim.keymap.set("t", "<C-S-`>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })

--------------
-- AUTOCMDS --
--------------
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("LastCursorPlace", {}),
  pattern = "*",
  command = 'silent! normal! g`"zv',
  desc = "Return cursor to where it was last time closing the file",
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client:supports_method "textDocument/completion" then
--       local opts = function(desc)
--         return { buffer = args.buf, desc = desc }
--       end
--       vim.o.completeopt = "menu,menuone,noinsert,fuzzy,popup" -- Customize built-in completions
--       vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--       vim.keymap.set({ "i" }, "<C-Space>", vim.lsp.completion.get, opts "Trigger completion")
--     end
--   end,
--   desc = "Built-in completion",
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "Visual", timeout = 300 }
  end,
  desc = "Highlight yanked text",
})

-----------------
-- DIAGNOSTICS --
-----------------
local icons = {
  Error = "",
  Warn = "",
  Hint = "󰌵",
  Info = "",
}

local signs = {
  text = {},
  numhl = {},
  texthl = {},
}

for type, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. type
  local severity = vim.diagnostic.severity[string.upper(type)]

  signs.text[severity] = icon
  signs.numhl[severity] = hl
  signs.texthl[severity] = hl
end

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    source = true,
    spacing = 0,
  },
  float = {
    source = true,
    border = "rounded",
  },
  update_in_insert = true,
  severity_sort = true,
  signs = signs,
}

local map = vim.keymap.set

map("n", "\\d", function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_enabled = vim.diagnostic.is_enabled { bufnr = buf_id }
  vim.diagnostic.enable(not is_enabled, { bufnr = buf_id })
  local new_buf_state = not is_enabled
  return new_buf_state and "  diagnostic" or "nodiagnostic"
end, { silent = true, desc = "Toggle 'diagnostics'" })

map("n", "[d", function()
  return vim.diagnostic.jump {
    count = -1,
    float = false,
  }
end, { silent = true, desc = "Previous Diagnostic" })
map("n", "]d", function()
  return vim.diagnostic.jump {
    count = 1,
    float = false,
  }
end, { silent = true, desc = "Next Diagnostic" })

map("n", "<leader>cd", function()
  vim.diagnostic.open_float(nil, {
    focusable = false,
  })
end, { silent = true, desc = "Code Open Diagnostics" })

map("n", "<leader>cD", ":Telescope diagnostics<CR>", { silent = true, desc = "Code Diagnostic List" })
map("n", "<leader>cq", ":Telescope quickfix<CR>", { silent = true, desc = "Code Quickfix" })
map("n", "<leader>cQ", ":Telescope quickfixhistory<CR>", { silent = true, desc = "Code Quickfix History" })

--------------------
-- PLUGIN MANAGER --
--------------------
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  }
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
require("lazy").setup({
  "nvim-treesitter/nvim-treesitter",
  build = function()
    local ts_update = require("nvim-treesitter.install").update {
      with_sync = true,
    }
    ts_update()
  end,
  config = function()
    local ts_config = require "nvim-treesitter.configs"

    ts_config.setup {
      ensure_installed = "all",
    }
  end,
}, {
  change_detection = {
    enabled = false,
    notify = false,
  },
})
