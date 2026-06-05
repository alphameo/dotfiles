local ft = "typst"
return {
  "chomosuke/typst-preview.nvim",
  lazy = true,
  ft = ft,
  cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" },
  config = function()
    require("typst-preview").setup {
      dependencies_bin = {
        tinymist = "tinymist",
      },
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        local map = vim.keymap.set
        map(
          "n",
          "<leader>lp",
          ":TypstPreviewToggle<CR>",
          { buffer = true, silent = true, desc = "Typst Preview Toggle" }
        )
      end,
    })
  end,
}
