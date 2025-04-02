local jdtls = require "jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.HOME .. "/jdtls-workspace/" .. project_name

local bundles = {
  vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n")
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

  root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },

  settings = {
    java = {
      -- TODO: path to the main java version (JDK 17 or higher)
      home = "/usr/lib/jvm/java-23-openjdk",

      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-23",
            path = "/usr/lib/jvm/java-23-openjdk",
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
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      signatureHelp = {
        enabled = true,
      },
      contentProvider = {
        preferred = "fernflower",
      },
      saveActions = {
        organizeImports = true,
      },
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
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      references = {
        includeDecompiledSources = true,
      },
    },
  },
  capabilities = require("configs.lspconfig").capabilities,
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = bundles,
  },

  on_attach = function(client, bufnr)
    jdtls.setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
}

-- Mappings
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

vim.keymap.set("n", "<leader>li", require("jdtls").organize_imports, { desc = "Java Organize Imports" })
vim.keymap.set("n", "<leader>lv", require("jdtls").extract_variable, { desc = "Java Extract Variable" })
vim.keymap.set("n", "<leader>lc", require("jdtls").extract_constant, { desc = "Java Extract Constant" })

vim.keymap.set("n", "<leader>lt", require("jdtls").test_nearest_method, { desc = "Java Test Method" })
vim.keymap.set("n", "<leader>lT", require("jdtls").test_class, { desc = "Java Test Class" })

vim.keymap.set("n", "<leader>lu", "<Cmd> JdtUpdateConfig<CR>", { silent = true, desc = "Java Update Config" })
vim.keymap.set("n", "<leader>lr", "<Cmd> JdtRestart<CR>", { silent = true, desc = "Java Restart JDTLS" })

jdtls.start_or_attach(config)
