local cmd = vim.api.nvim_create_user_command

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
    vim.hl.on_yank { higroup = "Visual", timeout = 300 }
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
local toggle = require "custom.toggle"

cmd("CursorLine", toggle.cursorline, { desc = "Toggle Location Line" })
cmd("CursorCol", toggle.colorcolumn, { desc = "Toggle Location Column" })
cmd("RelNum", toggle.relativenumber, { desc = "Toggle Relative Numbers" })
cmd("Glyphs", toggle.glyphs, { desc = "Toggle Glyphs" })
cmd("Wrap", toggle.wrap, { desc = "Toggle Wrapping Locally" })
cmd("ColColumn", toggle.colorcolumn, { desc = "Toggle Colorcolumn" })
cmd("Spell", toggle.spell, { desc = "Toggle Spellcheck Locally" })
cmd("Diagnostics", toggle.diagnostics, { desc = "Toggle Diagnostics" })
cmd("Expandtab", toggle.expandtab, { desc = "Toggle Expandtab Locally" })

local indent = require "custom.indent"
cmd("Indent", indent.set, { nargs = 1 })

---------------
-- Terminals --
---------------
local term = require "custom.terminal"

cmd("ToggleSplitTerm", term.toggle_split_terminal, {})
cmd("ToggleFloatTerm", term.toggle_float_terminal, {})
