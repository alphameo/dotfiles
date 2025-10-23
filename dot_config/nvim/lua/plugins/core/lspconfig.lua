return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "FileType" },
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    config = function()
      require("lsp").setup()
    end,
  },
  {
    {
      "antosha417/nvim-lsp-file-operations",
      lazy = true,
      event = { "FileType" },
      dependencies = {
        "nvim-lua/plenary.nvim",
        -- Uncomment whichever supported plugin(s) you use
        -- "nvim-tree/nvim-tree.lua",
        "nvim-neo-tree/neo-tree.nvim",
        -- "simonmclean/triptych.nvim"
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    },
  },
}
