-- JDTLS (Java LSP) configuration
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.HOME .. "/jdtls-workspace/" .. project_name

-- Needed for debugging
local bundles = {
	vim.fn.glob(
		vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
	),
}

-- Needed for running/debugging unit tests
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n")
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
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

		-- Eclipse jdtls location
		"-jar",
		vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
		-- TODO: Update this to point to the correct jdtls subdirectory for your OS (config_linux, config_mac, config_win, etc)
		"-configuration",
		vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	settings = {
		java = {
			-- TODO: Replace this with the absolute path to your main java version (JDK 17 or higher)
			home = "/usr/lib/jvm/java-22-openjdk",

			configuration = {
				-- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
				updateBuildConfiguration = "interactive",
				-- TODO: Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
				-- The runtime name parameters need to match specific Java execution environments.
				runtimes = {
					{
						name = "JavaSE-22",
						path = "/usr/lib/jvm/java-22-openjdk",
					},
				},
			},
			format = {
				enabled = true,
				-- Formatting works by default, but you can refer to a specific file/URL if you choose
				settings = {
					url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
					-- url = "https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			signatureHelp = { enabled = true },
			-- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
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
				-- Try not to suggest imports from these packages in the code action window
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
				-- When generating toString use a json format
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				-- When generating hashCode and equals methods use the java 7 objects method
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
			-- enable inlay hints for parameter names,
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
	-- Needed for auto-completion with method signatures and placeholders
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		-- References the bundles defined above to support Debugging and Unit Testing
		bundles = bundles,
	},

	on_attach = function(client, bufnr)
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
		require("plugins.main.lspconfig").on_attach()
	end,
}

-- Mappings
vim.cmd(
	"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
)
-- Allow yourself/register to run JdtUpdateConfig as a Vim command
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
-- Allow yourself/register to run JdtBytecode as a Vim command
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
-- Allow yourself/register to run JdtShell as a Vim command
vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

vim.keymap.set(
	"n",
	"<leader>li",
	"<Cmd> lua require('jdtls').organize_imports()<CR>",
	{ desc = "Java: Organize Imports" }
)

vim.keymap.set(
	"n",
	"<leader>lv",
	"<Cmd> lua require('jdtls').extract_variable()<CR>",
	{ desc = "Java: Extract Variable" }
)
vim.keymap.set(
	"v",
	"<leader>lv",
	"<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
	{ desc = "Java: Extract Variable" }
)

vim.keymap.set(
	"n",
	"<leader>lc",
	"<Cmd> lua require('jdtls').extract_constant()<CR>",
	{ desc = "Java: Extract Constant" }
)
vim.keymap.set(
	"v",
	"<leader>lc",
	"<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
	{ desc = "Java: Extract Constant" }
)

vim.keymap.set(
	"n",
	"<leader>lt",
	"<Cmd> lua require('jdtls').test_nearest_method()<CR>",
	{ desc = "Java: Test Method" }
)
vim.keymap.set(

	"v",
	"<leader>ltm",
	"<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
	{ desc = "Java: Test Method" }
)

vim.keymap.set(
	"n",
	"<leader>lT",
	"<Cmd> lua require('jdtls').test_class()<CR>",
	{ desc = "Java: Test Class" }
)

vim.keymap.set("n", "<leader>lu", "<Cmd> JdtUpdateConfig<CR>", { desc = "Java: Update Config" })

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
