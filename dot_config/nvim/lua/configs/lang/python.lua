vim.lsp.config("basedpyright", {
  capabilities = {
    -- this will remove some of the diagnostics that duplicates those from ruff, idea taken and adapted from
    -- here: https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-1989619482
    textDocument = {
      publishDiagnostics = {
        tagSupport = { valueSet = { 2 } },
      },
      hover = {
        contentFormat = { "plaintex" },
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    -- use ruff for imports
    pyright = { disableOrganizeImports = true },
    basedpyright = {
      analysis = {
        -- ignore = { "*" },
        autoImportCompletions = true,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        inlayHints = {
          variableTypes = false,
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = false,
        },
        -- "off", "basic", "standard", "recommended", "strict", "all"
        typeCheckingMode = "standard",
      },
    },
  },
})
vim.lsp.enable "basedpyright"

-- vim.lsp.config("pyright", {
--   capabilities = {
--     -- this will remove some of the diagnostics that duplicates those from ruff, idea taken and adapted from
--     -- here: https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-1989619482
--     textDocument = {
--       publishDiagnostics = {
--         tagSupport = { valueSet = { 2 } },
--       },
--       hover = {
--         contentFormat = { "plaintex" },
--         dynamicRegistration = true,
--       },
--     },
--   },
--   settings = {
--     pyright = {
--       disableOrganizeImports = true, -- use ruff
--     },
--     python = {
--       analysis = {
--         -- ignore = { "*" },
--         autoImportCompletions = true,
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         diagnosticMode = "workspace",
--       },
--     },
--   },
-- })
-- vim.lsp.enable "pyright"

vim.lsp.config("ruff", {
  init_options = {
    -- the settings can be found here: https://docs.astral.sh/ruff/editors/settings/
    settings = {
      fixAll = true,
      organizeImports = true,
      showSyntaxErrors = true,
      codeAction = {
        disableRuleComment = { enable = false },
        fixViolation = { enable = false },
      },
      lint = { enable = true },
    },
  },
})
vim.lsp.enable "ruff"

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
