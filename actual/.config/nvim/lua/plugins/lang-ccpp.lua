local ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  ft = ft,
  config = function()
    require("clangd_extensions").setup {
      inlay_hints = {
        inline = false,
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        local map = vim.keymap.set
        map(
          "n",
          "<leader>lh",
          ":ClangdSwitchSourceHeader<CR>",
          { buffer = true, silent = true, desc = "C/C++ Switch Source/Header" }
        )
        map(
          "n",
          "<leader>lH",
          ":ClangdTypeHierarchy<CR>",
          { buffer = true, silent = true, desc = "C/C++ Type Hierarchy" }
        )
        map("n", "<leader>lt", ":ClangdAST<CR>", { buffer = true, silent = true, desc = "C/C++ Abstract Syntax Tree" })
        map("n", "<leader>lm", ":ClangdMemoryUsage<CR>", { buffer = true, silent = true, desc = "C/C++ Memory Usage" })
      end,
    })
  end,
}
