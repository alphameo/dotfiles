return {
  "chomosuke/typst-preview.nvim",
  lazy = true,
  ft = "typst",
  cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
  config = function()
    require("typst-preview").setup {
      dependencies_bin = {
        tinymist = "tinymist",
      },
    }
  end,
}
