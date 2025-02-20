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

-- INFO: Jupyter Notebooks
-- mkdir ~/.virtualenvs
-- python -m venv ~/.virtualenvs/neovim # create a new venv
-- # note, activate is a bash/zsh script, use activate.fish for fish shell
-- source ~/.virtualenvs/neovim/bin/activate # activate the venv
-- pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip jupytext
-- venv project_name # activate the project venv
-- pip install ipykernel
-- python -m ipykernel install --user --name project_name

vim.keymap.set("n", "<leader>li", ":MoltenInit<CR>", { silent = true, desc = "Molten Initialize" })
vim.keymap.set("n", "<leader>le", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Operator Selection" })
vim.keymap.set("n", "<leader>ll", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Evaluate Line" })
vim.keymap.set("n", "<leader>lr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate Cell" })
vim.keymap.set(
  "v",
  "<leader>lR",
  ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "Evaluate visual selection" }
)
vim.keymap.set("n", "<leader>ld", ":MoltenDelete<CR>", { silent = true, desc = "Delete Cell" })
vim.keymap.set("n", "<leader>lh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide Output" })
vim.keymap.set("n", "<leader>ls", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "Show/Enter Output" })

vim.keymap.set("n", "<leader>lI", function()
  local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
  if venv ~= nil then
    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd "MoltenInit python3"
  end
end, { desc = "Initialize Molten for python3", silent = true })
