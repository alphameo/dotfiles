return {
  "p00f/clangd_extensions.nvim",
  lazy = true,
  ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  opts = {
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
  },
  config = function()
    local map = vim.keymap.set
    map({ "n" }, "<leader>lh", ":ClangdSwitchSourceHeader<CR>", { silent = true, desc = "C/C++ Switch Source/Header" })
    map({ "n" }, "<leader>lH", ":ClangdTypeHierarchy<CR>", { silent = true, desc = "C/C++ Type Hierarchy" })
    map({ "n" }, "<leader>lt", ":ClangdAST<CR>", { silent = true, desc = "C/C++ Abstract Syntax Tree" })
    map({ "n" }, "<leader>lm", ":ClangdMemoryUsage<CR>", { silent = true, desc = "C/C++ Memory Usage" })
  end,
}
