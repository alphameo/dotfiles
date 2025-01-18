local lsp_utils = require "configs.lspconfig"

if lsp_utils.executable "typescript-language-server" then
  local function organize_imports()
    local params = {
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
    }
    vim.lsp.buf.execute_command(params)
  end

  require("lspconfig").ts_ls.setup {
    capabilities = lsp_utils.def_cap,

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
else
  vim.notify("ts_ls (TypeScript, JavaScript) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

-- DAP

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
