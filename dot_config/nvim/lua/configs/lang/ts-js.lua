local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

local js_based_langs = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
  "vue",
}

-- vim.lsp.config("vtsls", {
--   capabilities = lsp_utils.capabilities,
--
--   settings = {
--     typescript = {
--       inlayHints = {
--         parameterNames = { enabled = "all" },
--         parameterTypes = { enabled = true },
--         variableTypes = { enabled = true },
--         propertyDeclarationTypes = { enabled = true },
--         functionLikeReturnTypes = { enabled = true },
--         enumMemberValues = { enabled = true },
--       },
--     },
--   },
-- })
-- vim.lsp.enable "vtsls"

-- vim.g.markdown_fenced_languages = {
--   "ts=typescript",
-- }

-- vim.lsp.config("denols", {
--   capabilities = lsp_utils.capabilities,
--   filetypes = js_based_langs,
--   settings = {
--     deno = {
--       inlayHints = {
--         parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
--         parameterTypes = { enabled = true },
--         variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
--         propertyDeclarationTypes = { enabled = true },
--         functionLikeReturnTypes = { enable = true },
--         enumMemberValues = { enabled = true },
--       },
--     },
--   },
-- })
-- vim.lsp.enable "denols"

vim.lsp.config("ts_ls", {
  filetypes = js_based_langs,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})
vim.lsp.enable "ts_ls"
