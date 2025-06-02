return {
  "norcalli/nvim-colorizer.lua",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("colorizer").setup {
      DEFAULT_OPTIONS = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background",
      },
    }

    vim.cmd ":ColorizerToggle"
    vim.keymap.set("n", "<leader>aC", ":ColorizerToggle<CR>", { silent = true, desc = "Colorizer Toggle" })
  end,
}
