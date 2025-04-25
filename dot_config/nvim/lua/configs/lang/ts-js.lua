-- INFO: LSP
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

-- INFO: DAP

local dap = require "dap"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      os.getenv "HOME" .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

dap.adapters.firefox = {
  type = "executable",
  command = "node",
  args = { os.getenv "HOME" .. "/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" },
}

for _, language in ipairs(js_based_langs) do
  dap.configurations[language] = {
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      url = "http://localhost:3000",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = "/usr/bin/firefox",
    },
  }
end
