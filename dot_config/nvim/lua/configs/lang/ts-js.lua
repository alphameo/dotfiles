-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end

require("lspconfig").ts_ls.setup {
  capabilities = lsp_utils.capabilities,

  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
    preferences = {
      disableSuggestions = true,
    },
  },

  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },

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
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  },
}

for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node",
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
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    local success, err = pcall(require("lint").try_lint)
    if not success then
      vim.notify("Linting error: " .. tostring(err), vim.log.levels.ERROR)
    end
  end,
})
local lint_ft = lint.linters_by_ft
-- lint_ft.javascript = { "eslint_d" }
-- lint_ft.typescript = { "eslint_d" }
lint_ft.javascriptreact = { "eslint_d" }
lint_ft.typescriptreact = { "eslint_d" }
