-------------------
-- Main settings --
-------------------
local M = {}
local del_map = vim.keymap.del
del_map("n", "grn") -- Rename
del_map({ "n", "v" }, "gra") -- Code Actions
del_map("n", "grr") -- Go to References
del_map("n", "gri") -- Fo to Implementation
del_map("n", "grt") -- Fo to Type defenition
del_map("n", "gO") -- Document Symbols
del_map("i", "<C-s>") -- Signature Help

local lsp_b = vim.lsp.buf
M.actions = {
  def = lsp_b.definition,
  impl = lsp_b.implementation,
  ref = lsp_b.references,
  type_def = lsp_b.type_definition,
  doc_symb = lsp_b.document_symbol,
  wsp_symb = lsp_b.workspace_symbol,
}

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd "checkhealth vim.lsp"
end, {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local map = vim.keymap.set
    local opts = function(desc)
      return { buffer = args.buf, desc = desc }
    end

    map("n", "K", lsp_b.hover, opts "Show Doc Hover")
    map("i", "<C-S-k>", lsp_b.signature_help, opts "Show Signature Help")

    map("n", "gd", M.actions.def, opts "Go to Definitions")
    map("n", "gD", lsp_b.declaration, opts "Go to Declaration")
    map("n", "gI", M.actions.impl, opts "Go to Implementations")
    map("n", "gr", M.actions.ref, opts "Go to References")
    map("n", "gt", M.actions.type_def, opts "Go to Type Definition")

    map("n", "<leader>cs", M.actions.doc_symb, opts "Code Document Symbols")
    map("n", "<leader>cS", M.actions.wsp_symb, opts "Code Workspace Symbols")

    map({ "n", "v" }, "<leader>ca", lsp_b.code_action, opts "Code Actions")
    map("n", "<leader>cr", lsp_b.rename, opts "Code Rename")
    map("n", "<F2>", lsp_b.rename, opts "Code Rename")

    local lsp = vim.lsp
    map("n", "<leader>ah", function()
      lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { 0 })
    end, opts "Toggle Inlay Hints")

    if lsp.inlay_hint then
      lsp.inlay_hint.enable(true, { 0 })
    end
  end,
})

local function setup_lsp(name, opts)
  if opts then
    vim.lsp.config(name, opts)
  end

  vim.lsp.enable(name)
end

--------------------
-- Configurations --
--------------------
local global_cfg = {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false, -- autofill func placeholders
          labelDetailSupport = false, -- disable params in cmp window
        },
      },
    },
  },
}

local clangd_cfg = {
  capabilities = { offsetEncoding = { "utf-16" } },
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

local gopls_cfg = {
  cmd = { "gopls" },
  settings = {
    gopls = {
      buildFlags = { "-tags=e2e" },
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = false,
      diagnosticsDelay = "250ms",
      staticcheck = true,
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
      codelenses = {
        test = true,
        gc_details = true,
        generate = true,
        run_govulncheck = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        compositeLiteralFields = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        functionTypeParameters = true,
        rangeVariableTypes = true,
        compositeLiteralTypes = true,
      },
    },
  },
}
local jsonls_cfg = {
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
}
local kotlin_ls_cfg = {
  settings = {
    kotlin = {
      hints = {
        typeHints = true,
        parameterHints = true,
        chaineHints = true,
      },
    },
  },
}
local lua_ls_cfg = {
  settings = {
    Lua = {
      diagnostics = { disable = { "missing-fields" } },
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = {
          "${3rd}/luv/library",
          unpack(vim.api.nvim_get_runtime_file("", true)),
        },
      },
      format = { enable = false },
      hint = { enable = true },
    },
  },
}
local basedpyright_cfg = {
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
}
local pyright_cfg = {
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
local ruff_cfg = {
  capabilities = {
    hoverProvider = false,
  },
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
}
local rust_analyzer_cfg = {
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
        experimental = { enable = true },
      },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
    },
  },
}
local vtsls_cfg = {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "all" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
local denols_cfg = {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  settings = {
    deno = {
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enable = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
}
local ts_ls_cfg = {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  commands = {
    OrganizeImports = {
      function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
      end,
      description = "Organize Imports",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}
local yamlls_cfg = {
  capabilities = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        -- Must disable built-in schemaStore support to use
        -- schemas from SchemaStore.nvim plugin
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
    },
  },
}

local java_init_cfg = {
  root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      -- TODO: path to the main java version (JDK 17 or higher)
      home = "/usr/lib/jvm/java-24-openjdk",

      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-8",
            path = "/usr/lib/jvm/java-8-openjdk",
          },
          {
            name = "JavaSE-17",
            path = "/usr/lib/jvm/java-17-openjdk",
          },
          {
            name = "JavaSE-21",
            path = "/usr/lib/jvm/java-21-openjdk",
          },
          {
            name = "JavaSE-24",
            path = "/usr/lib/jvm/java-24-openjdk",
          },
        },
      },
      format = {
        enabled = true,
        settings = {
          -- url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
          -- path = "$HOME/.config/nvim//utility/styles/intellij-java-google-style.xml",
          -- url = "https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml",
          path = "$HOME/.config/nvim/utility/styles/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      saveActions = { organizeImports = true },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
        hashCodeEquals = { useJava7Objects = true },
        useBlocks = true,
      },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      inlayHints = {
        parameterNames = { enabled = "all" },
      },
      references = { includeDecompiledSources = true },
    },
  },
  -- capabilities = require("blink.cmp").get_lsp_capabilities(),
  flags = { allow_incremental_sync = true },
}

M.setup_global = function()
  vim.lsp.config("*", global_cfg)
end
M.setup_bash = function()
  setup_lsp "bashls"
end
M.setup_ccpp = function()
  setup_lsp("clangd", clangd_cfg)
end
M.setup_cmake = function()
  setup_lsp "neocmake"
end
M.setup_css = function()
  setup_lsp "cssls"
  setup_lsp "css_variables"
  setup_lsp "cssmodules_ls"
end
M.setup_go = function()
  setup_lsp("gopls", gopls_cfg)
end
M.setup_html = function()
  setup_lsp "html"
end
M.setup_java = function()
  vim.lsp.config("jdtls", java_init_cfg)
end
M.setup_json = function()
  setup_lsp("jsonls", jsonls_cfg)
end
M.setup_kotlin = function()
  setup_lsp("kotlin_language_server", kotlin_ls_cfg)
end
M.setup_lua = function()
  setup_lsp("lua_ls", lua_ls_cfg)
end
M.setup_markdown = function()
  setup_lsp "marksman"
end
M.setup_python = function()
  setup_lsp("basedpyright", basedpyright_cfg)
  -- setup("pyright", pyright_cfg)
  setup_lsp("ruff", ruff_cfg)
end
M.setup_rust = function()
  setup_lsp("rust_analyzer", rust_analyzer_cfg)
end
M.setup_sql = function()
  setup_lsp "sqlls"
end
M.setup_tex = function()
  setup_lsp "texlab"
end
M.setup_toml = function()
  setup_lsp "taplo"
end
M.setup_tsjs = function()
  -- setup("vtsls", vtsls_cfg)
  -- setup_lsp("denols", denols_cfg)
  setup_lsp("ts_ls", ts_ls_cfg)
end
M.setup_xml = function()
  setup_lsp "lemminx"
end
M.setup_yaml = function()
  setup_lsp("yamlls", yamlls_cfg)
end

M.start_or_attach_java = function()
  local jdtls = require "jdtls"
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.env.HOME .. "/jdtls-workspace/" .. project_name

  local bundles = {
    vim.fn.glob(
      vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
    ),
  }

  vim.list_extend(
    bundles,
    vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n")
  )

  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      -- "-Xmx4g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-javaagent:" .. vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",

      "-jar",
      vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
      -- TODO: jdtls subdirectory for the OS (config_linux, config_mac, config_win, etc)
      "-configuration",
      vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
      "-data",
      workspace_dir,
    },
    settings = {
      java = {
        extendedClientCapabilities = jdtls.extendedClientCapabilities,
      },
    },
    init_options = { bundles = bundles },
    on_attach = function()
      jdtls.setup_dap { hotcodereplace = "auto" }
      require("jdtls.dap").setup_dap_main_class_configs()
    end,
  }
  local extended_cfg = vim.tbl_deep_extend("force", java_init_cfg, config)

  jdtls.start_or_attach(extended_cfg)
end

------------
-- Setups --
------------
M.setup = function()
  M.setup_global()
  M.setup_bash()
  M.setup_ccpp()
  M.setup_cmake()
  M.setup_css()
  M.setup_go()
  M.setup_html()
  M.setup_java()
  M.setup_json()
  M.setup_kotlin()
  M.setup_lua()
  M.setup_markdown()
  M.setup_python()
  M.setup_rust()
  M.setup_sql()
  M.setup_tex()
  M.setup_toml()
  M.setup_tsjs()
  M.setup_xml()
  M.setup_yaml()
end

return M
