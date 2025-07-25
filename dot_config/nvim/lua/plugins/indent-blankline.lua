return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
  main = "ibl",
  config = function()
    require("ibl").setup {
      scope = {
        show_start = false,
        show_end = false,
        show_exact_scope = true,
      },
      exclude = {
        filetypes = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
        },
      },
    }
  end,
}
