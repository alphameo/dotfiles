local cmd = vim.api.nvim_create_user_command

------------------AUTOCMDS------------------

-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   group = vim.api.nvim_create_augroup("last-cursor-place", {}),
--   pattern = "*",
--   command = 'silent! normal! g`"zz',
--   desc = "Return cursor to where it was last time closing the file",
-- })
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last-cursor-place", {}),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering slightly so it's applied after render
      vim.schedule(function()
        vim.cmd "normal! zz"
      end)
    end
  end,
  desc = "Return cursor to where it was last time closing the file",
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client ~= nil and client:supports_method "textDocument/completion" then
--       vim.lsp.completion.enable(true, client.id, args.buf, {
--         autotrigger = false,
--       })
--     end
--   end,
--   desc = "Built-in completion",
-- })
-- vim.api.nvim_create_autocmd("InsertCharPre", {
--   callback = function()
--     if vim.fn.pumvisible() == 1 or vim.fn.state "m" == "m" then
--       return
--     end
--
--     require("custom.lsp").show_cmp()
--   end,
--   desc = "Built-in autocompletion",
-- })
-- vim.api.nvim_create_autocmd("CmdlineChanged", {
--   callback = function()
--     vim.fn.wildtrigger()
--   end,
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.hl.on_yank { higroup = "Visual", timeout = 200 }
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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "%", function()
      local fname = vim.fn.input "Enter filename: "
      if fname == "" then
        return
      end

      local dir = vim.b.netrw_curdir or vim.fn.getcwd()
      local path = dir .. "/" .. fname

      if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
        vim.notify("Already exists: " .. fname, vim.log.levels.WARN)
        return
      end

      if fname:match "/$" then
        vim.fn.mkdir(path, "p")
        vim.cmd "edit"
      else
        local f = io.open(path, "w")
        if not f then
          vim.notify("Failed to create: " .. fname, vim.log.levels.ERROR)
          return
        end
        f:close()

        local escaped = vim.fn.fnameescape(path)
        if vim.fn.winnr "#" == 0 then
          vim.cmd("edit " .. escaped)
        else
          vim.cmd "wincmd p"
          vim.cmd("edit " .. escaped)
        end
      end
    end, { buffer = true, silent = true, noremap = true, desc = "Create file in previous window" })
  end,
  desc = "netrw's built-in `%` opens new files in the netrw window instead of respecting `netrw_browse_split`",
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


local lsp = require "custom.lsp"
cmd("DiagnosticsRefresh", lsp.refresh_diagnostics, { desc = "Refresh Diagnostics" })
---------------
-- Terminals --
---------------
local term = require "custom.terminal"

cmd("ToggleSplitTerm", term.toggle_split_terminal, {})
cmd("ToggleFloatTerm", term.toggle_float_terminal, {})
