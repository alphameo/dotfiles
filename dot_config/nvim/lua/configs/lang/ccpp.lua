require("lspconfig").clangd.setup {
  -- on_attach = require("configs.lspconfig").on_attach,
  -- capabilities = require("configs.lspconfig").capabilities,

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

  capabilities = {
    offsetEncoding = { "utf-16" },
  },

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

local dap = require "dap"
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb",
  -- detached = false, -- on windows you may have to uncomment this:
}
for _, lang in ipairs { "c", "cpp", "rust" } do
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

require("lspconfig").neocmake.setup {}
