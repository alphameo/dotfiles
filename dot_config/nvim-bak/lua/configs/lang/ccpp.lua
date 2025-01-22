-- INFO: LSP
local lsp_utils = require "configs.lspconfig"

local new_capabilities = {
  offsetEncoding = { "utf-16" },
}

if lsp_utils.executable "clangd" then
  require("lspconfig").clangd.setup {
    capabilities = vim.tbl_deep_extend("force", lsp_utils.def_cap, new_capabilities),

    filetypes = { "c", "cpp", "cc" },

    flags = {
      debounce_text_changes = 500,
    },

    root_dir = function(fname)
      return require("lspconfig.util").root_pattern(
        "Makefile",
        "configure.ac",
        "configure.in",
        "config.h.in",
        "meson.build",
        "meson_options.txt",
        "build.ninja"
      )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
        "lspconfig.util"
      ).find_git_ancestor(fname)
    end,

    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },

    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
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
require("conform").formatters_by_ft.c = { "clang_format" }
require("conform").formatters_by_ft.cpp = { "clang_format" }

-- INFO: LINTING
require("lint").linters_by_ft.c = { "cpplint" }
require("lint").linters_by_ft.cpp = { "cpplint" }
