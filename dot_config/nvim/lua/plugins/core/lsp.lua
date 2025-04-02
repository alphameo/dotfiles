return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(e)
          local lsp = vim.lsp
          local lsp_b = lsp.buf
          local map = vim.keymap.set
          local opts = function(desc)
            return { buffer = e.buf, desc = desc }
          end

          local telescope = require "telescope.builtin"

          map({ "n", "i", "v" }, "<C-k>", lsp_b.hover, opts "Show Doc Hover")
          map({ "n", "i", "v" }, "<C-S-k>", lsp_b.signature_help, opts "Show Signature Help")

          map("n", "gd", telescope.lsp_definitions, opts "Go to Definitions")
          map("n", "gD", lsp_b.declaration, opts "Go to Declaration")
          map("n", "gI", telescope.lsp_implementations, opts "Go to Implementations")
          map("n", "gr", telescope.lsp_references, opts "Go to References")
          map("n", "gt", telescope.lsp_type_definitions, opts "Go to Type Definition")
          map("n", "gb", "<C-o>", opts "Go Back")

          map("n", "<leader>csd", telescope.lsp_document_symbols, opts "Code Symbols Document")
          map("n", "<leader>csw", telescope.lsp_dynamic_workspace_symbols, opts "Code Symbols Workspace")

          map({ "n", "v" }, "<leader>ca", lsp_b.code_action, opts "Code Actions")

          map("n", "<leader>cr", lsp_b.rename, opts "Code Rename")
          map("n", "<F2>", lsp_b.rename, opts "Code Rename")

          map("n", "<leader>ah", function()
            lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { 0 })
          end, opts "Toggle Inlay Hints")

          if lsp.inlay_hint then
            lsp.inlay_hint.enable(true, { 0 })
          end

          map("n", "[d", vim.diagnostic.goto_next, opts "Next Diagnostic")
          map("n", "]d", vim.diagnostic.goto_prev, opts "Previous Diagnostic")
        end,
      })
    end,
  },
}
