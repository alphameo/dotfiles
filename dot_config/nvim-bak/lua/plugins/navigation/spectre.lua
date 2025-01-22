return {
  "nvim-pack/nvim-spectre",
  config = function()
    require("spectre").setup {
      default = {
        replace = {
          cmd = "sed",
        },
      },
    }
    vim.keymap.set("n", "<leader>FF", require("spectre").toggle, { desc = "Spectre: Open" })
    vim.keymap.set(
      "n",
      "<leader>Fw",
      '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      { desc = "Find & Repalce Word" }
    )
    vim.keymap.set(
      "v",
      "<leader>Fw",
      '<esc><cmd>lua require("spectre").open_visual()<CR>',
      { desc = "Find & Replace Word" }
    )
    vim.keymap.set(
      "n",
      "<leader>Ff",
      '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      { desc = "Find & Replace on current file" }
    )
  end,
}
