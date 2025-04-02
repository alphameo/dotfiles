-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

require("lspconfig").clangd.setup {
  capabilities = lsp_utils.extended_capabilities { offsetEncoding = { "utf-16" } },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--all-scopes-completion",
    "--fallback-style=llvm",
  },
  settings = {
    clangd = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
      fallbackFlags = { "-std=c++20" },
    },
  },
}

-- INFO: DAP
local dap = require "dap"
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
  -- detached = false, -- on windows you may have to uncomment this:
  -- type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
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
  clang_format = {
    args = {
      "--style={BasedOnStyle: Google,"
        .. "UseTab: Never,"
        .. "TabWidth: 4,"
        .. "IndentWidth: 4,"
        .. "InsertNewlineAtEOF: true,"
        .. "IndentCaseLabels: true,"
        .. "LineEnding: LF,"
        .. "BreakBeforeBraces: Attach,"
        .. "AllowShortIfStatementsOnASingleLine: false,"
        .. "AllowShortBlocksOnASingleLine: Empty,"
        .. "IndentAccessModifiers: false,"
        .. "AccessModifierOffset: -3"
        .. "}",
    },
  },
}

-- INFO: LINTING
require("lint").linters_by_ft.c = { "cpplint" }
require("lint").linters_by_ft.cpp = { "cpplint" }
