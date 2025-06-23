vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("LastCursorPlace", {}),
  desc = "Return cursor to where it was last time closing the file",
  pattern = "*",
  command = 'silent! normal! g`"zv',
})

-- INFO: LSP DEFAULTCMP
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

-- INFO: TERM
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

-- INFO: Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank { higroup = "Visual", timeout = 300 }
  end,
  desc = "Highlight yanked text",
})

-- INFO: Detect filetype
-- TODO: Remove after fixing non=detecting (mason and BlinkCMP, maybe treesitter)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "" then
      vim.cmd "filetype detect" -- Force detection
    end
  end,
})

-- INFO: Trim whitespaces
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trim-white-space", {}),
  pattern = "*",
  command = "%s/\\s\\+$//e",
})
