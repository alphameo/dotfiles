return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    vim.g.vimtex_view_method = "zathura"
    -- From: https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt#L4671-L4713
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
    vim.o.foldtext = "vimtex#fold#text()"
    -- I like to see at least the content of the sections upon opening
    vim.o.foldlevel = 2
  end,
  -- config = function ()
  --   vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
  --   vim.g.vimtex_quickfix_methob = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
  -- end,
  -- keys = {
  --   { "<localLeader>l", "", desc = "vimtex" },
  -- },
}
