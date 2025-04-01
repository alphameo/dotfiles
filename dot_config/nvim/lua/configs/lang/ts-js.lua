-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

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

require("lspconfig").ts_ls.setup {
  capabilities = lsp_utils.capabilities,

  filetypes = js_based_langs,

  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}

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

-- INFO: FORMATTING
local conform_ft = require("conform").formatters_by_ft
conform_ft.javascript = { "prettierd" }
conform_ft.typescript = { "prettierd" }
conform_ft.javascriptreact = { "prettierd" }
conform_ft.typescriptreact = { "prettierd" }

-- INFO: LINTING

vim.env.ESLINT_D_PPID = vim.fn.getpid()
local lint = require "lint"

lint.linters.eslint_d = {
  cmd = "eslint_d",
  stdin = true,
  args = {
    "--config",
    os.getenv "ESLINT_D_DEFAULT_CONFIG",
  },
}

local lint_ft = lint.linters_by_ft
-- lint_ft.javascript = { "eslint_d" }
-- lint_ft.typescript = { "eslint_d" }
-- lint_ft.javascriptreact = { "eslint_d" }
-- lint_ft.typescriptreact = { "eslint_d" }
