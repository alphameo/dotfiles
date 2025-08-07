-------------------
-- Main settings --
-------------------
local M = {}
local lsp_b = vim.lsp.buf
M.actions = {
  def = lsp_b.definition,
  impl = lsp_b.implementation,
  ref = lsp_b.references,
  type_def = lsp_b.type_definition,
  doc_symb = lsp_b.document_symbol,
  wsp_symb = lsp_b.workspace_symbol,
}

local setup_mappings = function()
  local del_map = vim.keymap.del
  del_map("n", "grn") -- Rename
  del_map({ "n", "v" }, "gra") -- Code Actions
  del_map("n", "grr") -- Go to References
  del_map("n", "gri") -- Fo to Implementation
  del_map("n", "grt") -- Fo to Type defenition
  del_map("n", "gO") -- Document Symbols
  del_map("i", "<C-s>") -- Signature Help

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
      map("n", "\\h", function()
        lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { 0 })
      end, opts "Toggle Inlay Hints")

      if lsp.inlay_hint then
        lsp.inlay_hint.enable(true, { 0 })
      end
    end,
  })
end

-- INFO: check default  lua print(vim.inspect(vim.lsp.protocol.make_client_capabilities()))
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
  -- capabilities = vim.lsp.protocol.make_client_capabilities(),
  flags = { allow_incremental_sync = true },
}

local setup_java = function()
  vim.lsp.config("jdtls", java_init_cfg)
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
  vim.lsp.config("*", global_cfg)
  vim.lsp.enable {
    "bashls",
    "clangd",
    "neocmake",
    "cssls",
    "css_variables",
    "cssmodules_ls",
    "gopls",
    "html",
    "jsonls",
    "kotlin_language_server",
    "lua_ls",
    "marksman",
    "ruff",
    -- "pyright",
    "basedpyright",
    "rust_analyzer",
    "sqlls",
    "texlab",
    "taplo",
    "ts_ls",
    -- "vtsls",
    -- "denols",
    "lemminx",
    "yamlls",
  }

  setup_java()
  setup_mappings()
end

return M
