return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    -- stylua: ignore
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local map = vim.keymap.set
          local b = e.buf
          local telescope = require("telescope.builtin")

          map({ "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, { buffer = b, desc = "Show Doc Hover" })
          map({ "n", "i", "v" }, "<C-S-k>", vim.lsp.buf.signature_help, { buffer = b, desc = "Show Signature Help" })

          map("n", "gd", telescope.lsp_definitions, { buffer = b, desc = "Go to Definitions" })
          map("n", "gD", vim.lsp.buf.declaration, { buffer = b, desc = "Go to Declaration" })
          map("n", "gI", telescope.lsp_implementations, { buffer = b, desc = "Go to Implementations" })
          map("n", "gr", telescope.lsp_references, { buffer = b, desc = "Go to References" })
          map("n", "gt", telescope.lsp_type_definitions, { buffer = b, desc = "Go to Type defenition" })
          map("n", "gb", "<C-o>", { buffer = b, desc = "Go Back" })

          map("n", "<leader>csd", telescope.lsp_document_symbols, { buffer = b, desc = "Code Symbols Document" })
          map("n", "<leader>csw", telescope.lsp_dynamic_workspace_symbols, { buffer = b, desc = "Code Symbols Workspace" })

          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = b, desc = "Code Actions" })

          map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = b, desc = "Code Rename" })
          map("n", "<F2>", vim.lsp.buf.rename, { buffer = b, desc = "Code Rename" })

          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { 0 })
            map("n", "<leader>ah", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
            end, { buffer = b, desc = "Toggle Inlay Hints" })
          end

          vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { buffer = b })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { buffer = b })
        end,
      })
    end,
  },
}
