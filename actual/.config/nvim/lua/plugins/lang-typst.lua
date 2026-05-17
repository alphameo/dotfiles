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
        map(
          "n",
          "<leader>les",
          ":LspTinymistExportSvg<CR>",
          { buffer = true, silent = true, desc = "Typst Export SVG" }
        )
        map(
          "n",
          "<leader>lep",
          ":LspTinymistExportPng<CR>",
          { buffer = true, silent = true, desc = "Typst Export PNG" }
        )
        map(
          "n",
          "<leader>leP",
          ":LspTinymistExportPdf<CR>",
          { buffer = true, silent = true, desc = "Typst Export PDF" }
        )
        map(
          "n",
          "<leader>lem",
          ":LspTinymistExportPdf<CR>",
          { buffer = true, silent = true, desc = "Typst Export Markdown" }
        )
        map(
          "n",
          "<leader>li",
          ":LspTinymistGetServerInfo<CR>",
          { buffer = true, silent = true, desc = "Typst server Info" }
        )
        map(
          "n",
          "<leader>lt",
          ":LspTinymistGetDocumentTrace<CR>",
          { buffer = true, silent = true, desc = "Typst document Trace" }
        )
        map(
          "n",
          "<leader>ll",
          ":LspTinymistGetWorkspaceLabels<CR>",
          { buffer = true, silent = true, desc = "Typst workspace Labels" }
        )
        map(
          "n",
          "<leader>lm",
          ":LspTinymistGetDocumentMetrics<CR>",
          { buffer = true, silent = true, desc = "Typst document Metrics" }
        )
        map("n", "<leader>lM", ":LspTinymistPinMain<CR>", { buffer = true, silent = true, desc = "Typst pin Main" })
      end,
    })
  end,
}
