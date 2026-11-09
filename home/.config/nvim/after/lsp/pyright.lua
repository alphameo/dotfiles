return {
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
    pyright = {
      disableOrganizeImports = true, -- use ruff
    },
    python = {
      analysis = {
        -- ignore = { "*" },
        autoImportCompletions = true,
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
}
