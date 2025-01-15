local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.on_attach = function(_, bufnr)
  local map = vim.keymap.set

  map({ "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, { desc = "Show Doc Hover" })
  map({ "n", "i", "v" }, "<C-S-k>", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })

  map("n", "<leader>gd", require("telescope.builtin").lsp_definitions, { desc = "Goto Definition" })
  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions { reuse_win = true }
  end, { desc = "Goto Definition" })

  map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })

  map("n", "<leader>gI", require("telescope.builtin").lsp_implementations, { desc = "Goto Implementations" })
  map("n", "gI", function()
    require("telescope.builtin").lsp_implementations { reuse_win = true }
  end, { desc = "Goto Implementations" })

  map("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "Goto References" })
  map("n", "gr", function()
    require("telescope.builtin").lsp_references { reuse_win = true }
  end, { desc = "Goto References" })

  map("n", "<leader>gt", require("telescope.builtin").lsp_type_definitions, { desc = "Goto Type defenition" })
  map("n", "gt", function()
    require("telescope.builtin").lsp_type_definitions { reuse_win = true }
  end, { desc = "Goto Type defenition" })

  map("n", "<leader>gb", "<C-o>", { desc = "Go Back" })
  map("n", "gb", "<C-o>", { desc = "Go Back" })

  map("n", "<leader>csd", require("telescope.builtin").lsp_document_symbols, { desc = "Code Symbols Document" })
  map(
    "n",
    "<leader>csw",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    { desc = "Code Symbols Workspace" }
  )

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })

  map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Code Rename" })
  map("n", "<F2>", vim.lsp.buf.rename, { desc = "Code Rename" })

  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { 0 })
    map("n", "<leader>ah", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
    end, { desc = "Toggle Inlay Hints" })
  end
end

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

return M
