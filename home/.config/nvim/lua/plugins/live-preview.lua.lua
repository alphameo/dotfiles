local ft = { "html" }
return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    -- You can choose one of the following pickers
    -- 'nvim-telescope/telescope.nvim',
    "ibhagwan/fzf-lua",
    -- 'echasnovski/mini.pick',
    -- 'folke/snacks.nvim',
  },
  ft = ft,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft,
      callback = function()
        local map = vim.keymap.set
        map("n", "<leader>lp", ":LivePreview start<CR>", { buffer = true, silent = true, desc = "Start Live Preview" })
      end,
    })
  end,
}
