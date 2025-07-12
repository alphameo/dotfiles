-------------
-- OPTIONS --
-------------
local opt = vim.opt
-- Basic
opt.number = true -- Line numbers (false)
opt.relativenumber = true -- Set relative numbered lines (false)
opt.cursorline = true -- Highlight current line (false)
opt.wrap = false -- Display lines as one long line (true)
opt.linebreak = true -- Companion to wrap, don't split words (false)
opt.scrolloff = 10 -- Keep n lines above/below cursor (0)
opt.sidescrolloff = 8 -- Keep n columns left/right of cursor (0)
-- Indentation
opt.tabstop = 4 -- Tab width (8)
opt.shiftwidth = 4 -- Indent width (8)
opt.softtabstop = 4 -- Number of spaces that tab counts (0)
opt.expandtab = true -- Spaces instead of tabs (false)
opt.smartindent = true -- Smart auto-indenting (false)
opt.autoindent = true -- Copy indent from current line (true)
opt.breakindent = true -- Keep wrapped line on same indent level (default: false)
-- Search
opt.ignorecase = true -- Case-insensitive search (false)
opt.smartcase = true -- Case sensitive if uppercase in search (false)
opt.hlsearch = false -- Highlight search results (true)
opt.incsearch = true -- Show matches as you type (false)
-- Visual
opt.termguicolors = true -- 24-bit colors (false)
opt.signcolumn = "yes" -- Show signcolumn ("auto")
opt.colorcolumn = "" -- Show column at "n" characters
opt.conceallevel = 0 -- Visual-control chars (**, '') in md etc. (0 - visible, 1-faded(def), 2-hidden, 3-idk)
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
-- File Handling
opt.backup = false -- Creates a backup file (false)
opt.swapfile = false -- Creates a swapfile (true)
opt.undofile = true -- Save undo history (false)
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.updatetime = 300 -- Decrease update time (4000)
opt.encoding = "UTF-8" -- Set encoding
opt.isfname:append "@-@" -- Allow @ for filenames
-- Input
opt.clipboard:append "unnamedplus" -- Use system clipboard ('')
opt.timeoutlen = 200 -- Key timeout duration (500)
opt.ttimeoutlen = 10 -- Key code timeout
opt.mouse = "a" -- Enable mouse support (default: '')
-- Other
opt.spelllang = "ru_ru,en_us"
opt.spell = false
vim.filetype.add {
  pattern = {
    [".*/.config/hypr/.*%.conf"] = "hyprlang",
    [".*/.config/waybar/.*%.css"] = "gtkcss",
    [".*/.config/rofi/.*%.css"] = "gtkcss",
    [".*/.config/kitty/.*%.conf"] = "kitty",
  },
}

--------------
-- MAPPINGS --
--------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- File
map("n", "<C-s>", ":w<CR>", { silent = true, desc = "Save File" })
map("n", "<C-S-s>", ":wall<CR>", { silent = true, desc = "Save All Files" })
map("n", "<C-q>", ":q<CR>", { silent = true, desc = "Quit" })
map("n", "<C-S-q>", ":q!<CR>", { silent = true, desc = "Force Quit" })
-- Appearance
map("n", "<leader>aw", ":set wrap!<CR>", { silent = true, desc = "Toggle Line Wrap" })
-- Buffers
map("n", "<C-t>", ":enew<CR>", { silent = true, desc = "Tab New" }) -- new buffer
map("n", "<C-x>", ":Bdelete!<CR>", { silent = true, desc = "Tab Quit" }) -- close buffer
-- Windows
map("n", "<C-S-\\>", "<C-w>s", { desc = "Window Horizontal Split" })
map("n", "<C-\\>", "<C-w>v", { desc = "Window Vertical Split" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<C-=>", "<C-w>+", { desc = "Window Taller" })
map("n", "<C-->", "<C-w>-", { desc = "Window Shorter" })
map("n", "<C-.>", "<C-w>>", { desc = "Window Wider" })
map("n", "<C-,>", "<C-w><", { desc = "Window Narower" })
-- Comments
map("i", "<C-/>", "<ESC>:Commentary<CR>", { silent = true, desc = "Toggle Comment" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
map("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })
-- Features
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true }) -- disable the spacebar key's default behavior
map("v", "<", "<gv", { desc = "Indent Left" }) -- stay in visual mode after indent
map("v", ">", ">gv", { desc = "Indent Right" }) -- stay in visual mode after indent
map("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move Line Down" })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move Line Up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Selection Down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Selection Up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Page Down" }) -- center after scroll down
map("n", "<C-u>", "<C-u>zz", { desc = "Page Up" }) -- center after scroll up
map("n", "n", "nzzzv", { desc = "Next Occurance" }) -- center after find
map("n", "N", "Nzzzv", { desc = "Previous Occurance" }) -- center after find
map("n", "<C-e>", "5<C-e>", { desc = "Scroll Down" }) -- faster scroll without cursor
map("n", "<C-y>", "5<C-y>", { desc = "Scroll Up" }) -- faster scroll without cursor
vim.keymap.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true }) -- paste without yanking
map("i", "jk", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "jj", "<ESC>", { desc = "Exit INSERT MODE" })
map("i", "kj", "<ESC>", { desc = "Exit INSERT MODE" })
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

local map = vim.keymap.set
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })

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

map("n", "<leader>ts", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("n", "<C-`>", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<leader>ts", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<C-`>", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })

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

map("n", "<leader>tf", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("n", "<C-S-`>", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<C-S-`>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })

--------------
-- AUTOCMDS --
--------------
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("LastCursorPlace", {}),
  pattern = "*",
  command = 'silent! normal! g`"zv',
  desc = "Return cursor to where it was last time closing the file",
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client:supports_method "textDocument/completion" then
--       local map = vim.keymap.set
--       local opts = function(desc)
--         return { buffer = args.buf, desc = desc }
--       end
--       vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--       map({ "i" }, "<C- >", "<C-x><C-o>", opts "Trigger completion")
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("term-autoinsert", { clear = true }),
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd ":startinsert"
    end
  end,
  desc = "Autoinsert on terminal open",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "Visual", timeout = 300 }
  end,
  desc = "Highlight yanked text",
})

-- TODO: Remove after fixing non=detecting (mason and BlinkCMP, maybe treesitter)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "" then
      vim.cmd "filetype detect" -- Force detection
    end
  end,
  desc = "Detect filetype",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trim-white-space", {}),
  pattern = "*",
  command = "%s/\\s\\+$//e",
  desc = "Trim whitespaces",
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

map("n", "<leader>cD", function()
  if not vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end, { silent = true, desc = "Code Diagnostics Toggle" })

map("n", "<leader>cL", function()
  vim.opt_local.spell = not (vim.opt_local.spell:get())
  vim.notify("spell check: " .. tostring(vim.o.spell))
end, { desc = "Code SpellCheck Toggle" })

map("n", "[d", function()
  return vim.diagnostic.jump {
    count = -1,
    float = true,
  }
end, { silent = true, desc = "Previous Diagnostic" })
map("n", "]d", function()
  return vim.diagnostic.jump {
    count = 1,
    float = true,
  }
end, { silent = true, desc = "Next Diagnostic" })

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
