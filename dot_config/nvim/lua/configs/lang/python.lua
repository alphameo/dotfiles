-- INFO: LSP
local lspconfig = require "lspconfig"

local lsp_utils = require "configs.lspconfig"
local def_cap = lsp_utils.capabilities

if lsp_utils.executable "pyright" then
  local new_capability = {
    -- this will remove some of the diagnostics that duplicates those from ruff, idea taken and adapted from
    -- here: https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-1989619482
    textDocument = {
      publishDiagnostics = {
        tagSupport = {
          valueSet = { 2 },
        },
      },
      hover = {
        contentFormat = { "markdown", "plaintex" },
        dynamicRegistration = true,
      },
    },
  }

  lspconfig.pyright.setup {
    cmd = { "pyright-langserver", "--stdio" },
    capabilities = vim.tbl_deep_extend("force", def_cap, new_capability),
    filetypes = { "python" },
    settings = {
      pyright = {
        -- disable import sorting and use Ruff for this
        disableOrganizeImports = true,
        disableTaggedHints = false,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          typeCheckingMode = "standard",
          useLibraryCodeForTypes = true,
          -- we can this setting below to redefine some diagnostics
          diagnosticSeverityOverrides = {
            deprecateTypingAliases = false,
          },
          -- inlay hint settings are provided by pylance?
          inlayHints = {
            callArgumentNames = "partial",
            functionReturnTypes = true,
            pytestParameters = true,
            variableTypes = true,
          },
        },
      },
    },
  }
else
  vim.notify("pyright (python) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

if lsp_utils.executable "ruff" then
  require("lspconfig").ruff.setup {
    capabilities = def_cap,
    init_options = {
      -- the settings can be found here: https://docs.astral.sh/ruff/editors/settings/
      settings = {
        organizeImports = true,
      },
    },
  }
else
  vim.notify("ruff (python) not found!", vim.log.levels.WARN, { title = "Nvim-config" })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client == nil then
      return
    end
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = "LSP: Disable hover capability from Ruff",
})

-- INFO: DAP
require("dap-python").setup(vim.env.HOME .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
require("dap-python").default_port = 38000

-- INFO: FORMATTING
require("conform").formatters_by_ft.python = { "black" }

-- INFO: LINTING
require("lint").linters_by_ft.python = { "mypy" }
