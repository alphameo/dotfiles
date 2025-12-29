return {
  capabilities = {
    -- this will remove some of the diagnostics that duplicates those from ruff, idea taken and adapted from
    -- here: https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-1989619482
    textDocument = {
      publishDiagnostics = {
        tagSupport = { valueSet = { 2 } },
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
}
