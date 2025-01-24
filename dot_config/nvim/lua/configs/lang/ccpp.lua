-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

local new_capabilities = {
  offsetEncoding = { "utf-16" },
}

if lsp_utils.executable "clangd" then
  require("lspconfig").clangd.setup {
    capabilities = vim.tbl_deep_extend("force", lsp_utils.capabilities, new_capabilities),
  }
else
  vim.notify("clangd (c, cpp) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- INFO: DAP
local dap = require "dap"
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
  -- detached = false, -- on windows you may have to uncomment this:
}
for _, lang in ipairs { "c", "cpp" } do
  dap.configurations[lang] = {
    {
      type = "codelldb",
      request = "launch",
      name = "Launch file",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
    },
    {
      type = "codelldb",
      request = "attach",
      name = "Attach to process",
      pid = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end

-- INFO: FORMATTING
local conform = require "conform"
conform.formatters_by_ft.c = { "clang_format" }
conform.formatters_by_ft.cpp = { "clang_format" }
conform.formatters = {
  ["clang-format"] = {
    prepend_args = {
      "-style={ \
                BasedOnStyle: Google, \
                UseTab: Never, \
                TabWidth: 4, \
                indentWidth: 4, \
                InsertNewlineAtEOF: true, \
                IndentCaseLabels: true, \
                BreakBeforeBraces: Attach, \
                AllowShortIfStatementsOnASingleLine: false, \
                AllowShortBlocksOnASingleLine: Empty}",
    },
  },
}

-- INFO: LINTING
require("lint").linters_by_ft.c = { "cpplint" }
require("lint").linters_by_ft.cpp = { "cpplint" }
