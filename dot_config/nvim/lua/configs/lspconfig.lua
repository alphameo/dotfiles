local M = {}
local fn = vim.fn

function M.executable(name)
  if fn.executable(name) > 0 then
    return true
  end

  return false
end

M.pref_cap = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
M.pref_cap.textDocument.completion.completionItem.snippetSupport = false -- autofill func placeholders
M.pref_cap.textDocument.completion.completionItem.labelDetailsSupport = false -- disable params in cmp window

-- NOTE: The same code-block via table extension with all defaults
-- M.cmp_cap = require("cmp_nvim_lsp").default_capabilities()
-- M.lsp_cap = vim.lsp.protocol.make_client_capabilities()
-- M.ext_cap = vim.tbl_deep_extend("force", {}, M.lsp_cap, M.cmp_cap)

-- NOTE: The same code-block via manual setup with all defaults
-- M.large_cap = vim.lsp.protocol.make_client_capabilities()
-- M.large_cap.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }

M.capabilities = M.pref_cap

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

return M
