return {
  cmd = { "gopls" },
  settings = {
    gopls = {
      -- Build
      buildFlags = { "-tags=e2e" },
      -- Formatting
      gofumpt = true,
      -- UI
      codelenses = {
        generate = true,
        regenerate_cgo = true,
        test = true,
        -- run_govulncheck = true, -- legacy
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
        vulncheck = true,
      },
      semanticTokens = true,
      newGoFileHeader = true,
      renameMovesSubpackages = true,
      moveType = true,
      -- Completion
      usePlaceholders = false,
      completeFunctionCalls = false,
      -- Diagnostics
      analyses = {
        recursiveiter = true,
        maprange = true,
        framepointer = true,
        modernize = true,
        nilness = true,
        hostport = true,
        gofix = true,
        sigchanyzer = true,
        stdversion = true,
        unreachable = true,
        unusedfunc = true,
        unusedparams = true,
        unusedvariable = true,
        unusedwrite = true,
        useany = true,
      },
      staticcheck = true,
      vulncheck = "Prompt", -- "Imports" | "Off" | "Prompt"
      -- diagnosticsDelay = "250ms",
      diagnosticsTrigger = "Edit", -- "Edit" | "Save"
      analysisProgressReporting = true,
      -- Inlayhint
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        ignoredError = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
