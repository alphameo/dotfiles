return {
  "lukas-reineke/indent-blankline.nvim",
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile", "VeryLazy" },
  main = "ibl",
  config = function()
    require("ibl").setup {
      indent = { char = "▎" },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
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
          "ministarter",
        },
      },
    }
  end,
}
