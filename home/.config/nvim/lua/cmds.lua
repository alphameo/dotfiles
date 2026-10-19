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
local utils = require "utils"

cmd("CursorLine", utils.toggle_cursorline, { desc = "Toggle Location Line" })
cmd("CursorCol", utils.toggle_cursorcolumn, { desc = "Toggle Location Column" })
cmd("RelNum", utils.toggle_relativenumber, { desc = "Toggle Relative Numbers" })
cmd("Glyphs", utils.toggle_glyphs, { desc = "Toggle Glyphs" })
cmd("Wrap", utils.toggle_wrap, { desc = "Toggle Wrapping Locally" })
cmd("ColColumn", utils.toggle_colorcolumn, { desc = "Toggle Colorcolumn" })
cmd("Spell", utils.toggle_spell, { desc = "Toggle Spellcheck Locally" })
cmd("Diagnostics", utils.toggle_diagnostics, { desc = "Toggle Diagnostics" })
cmd("Expandtab", utils.toggle_expandtab, { desc = "Toggle Expandtab Locally" })

local set_indent = function(opts)
  local width = tonumber(opts.args)
  vim.bo.expandtab = true
  vim.bo.tabstop = width
  vim.bo.softtabstop = width
  vim.bo.shiftwidth = width

  print("local_indent=" .. width)
end
cmd("Indent", set_indent, { nargs = 1 })

local refresh_diagnostics = function()
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client:supports_method "workspace/diagnostic" then
      vim.lsp.buf.workspace_diagnostics { client_id = client.id }
    else
      vim.diagnostic.reset(nil, 0)
      vim.cmd "checktime"
    end
  end
  vim.notify("Diagnostics refreshed", vim.log.levels.INFO)
end
cmd("DiagnosticsRefresh", refresh_diagnostics, { desc = "Refresh Diagnostics" })
