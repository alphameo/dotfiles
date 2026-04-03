local cmd = vim.api.nvim_create_user_command
local map = vim.keymap.set

------------------AUTOCMDS------------------

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("last-cursor-place", {}),
  pattern = "*",
  command = 'silent! normal! g`"zz',
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
--       map({ "i" }, "<C-Space>", vim.lsp.completion.get, opts "Trigger completion")
--     end
--   end,
--   desc = "Built-in completion",
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 300 }
  end,
  desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
  desc = "Open HELP in vertical split",
})

vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
  desc = "Auto-resize splits on terminal window resizing",
})

------------------USERCMDS------------------
--------------
-- Togglers --
--------------
cmd("CursorLine", "set cursorline! cursorline?", { desc = "Toggle Location Line" })
cmd("CursorCol", "set cursorcolumn! cursorcolumn?", { desc = "Toggle Location Column" })
cmd("RelNum", ":set relativenumber! relativenumber?", { desc = "Toggle Relative Numbers" })
cmd("Glyphs", "set list! list?", { desc = "Toggle Glyphs" })
cmd("Wrap", "setlocal wrap! wrap?", { desc = "Toggle Wrapping" })
cmd("ColColumn", function()
  if vim.o.colorcolumn ~= "" then
    vim.o.colorcolumn = ""
  else
    vim.o.colorcolumn = "80"
  end
end, { desc = "Toggle Colorcolumn" })
cmd("Spell", "setlocal spell! spell?", { desc = "Toggle Spell Check" })
cmd("Diagnostics", function()
  local buf_id = vim.api.nvim_get_current_buf()
  local is_enabled = vim.diagnostic.is_enabled { bufnr = buf_id }
  vim.diagnostic.enable(not is_enabled, { bufnr = buf_id })
  -- local new_buf_state = not is_enabled
  -- return new_buf_state and "  diagnostic" or "nodiagnostic"
end, { desc = "Toggle Diagnostics" })

map("n", "\\s", ":Spell<CR>", { silent = true, desc = "Toggle Spellcheck" })
map("n", "\\w", ":Wrap<CR>", { silent = true, desc = "Toggle Wrapping" })
map("n", "\\d", ":Diagnostics<CR>", { silent = true, desc = "Toggle Diagnostic" })
map("n", "\\l", ":ColColumn<CR>", { silent = true, desc = "Toggle Limit Column" })

---------------
-- Terminals --
---------------
local util = require "util"
local term_win_state = {
  buf = -1,
  win = -1,
}

local toggle_terminal = function(create_win_func)
  if not vim.api.nvim_buf_is_valid(term_win_state.buf) then
    term_win_state.buf = util.create_hidden_buf()
  end
  if not vim.api.nvim_win_is_valid(term_win_state.win) or not vim.api.nvim_buf_is_valid(term_win_state.buf) then
    term_win_state.win = create_win_func(term_win_state.buf)
    if vim.bo[term_win_state.buf].buftype ~= "terminal" then
      vim.api.nvim_call_function("termopen", { vim.o.shell })
    end
    vim.cmd "startinsert"
  else
    vim.api.nvim_win_hide(term_win_state.win)
    vim.cmd "stopinsert"
  end
end

-- Split Terminal

local toggle_split_terminal = function()
  toggle_terminal(util.create_hidden_split)
end

cmd("ToggleSplitTerm", toggle_split_terminal, {})

map("n", "<leader>ts", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("n", "<C-`>", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<leader>ts", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<C-`>", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })

-- Float Terminal

local toggle_float_terminal = function()
  toggle_terminal(util.create_hidden_float)
end

cmd("ToggleFloatTerm", toggle_float_terminal, {})

map("n", "<leader>tf", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("n", "<C-S-`>", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<C-S-`>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
