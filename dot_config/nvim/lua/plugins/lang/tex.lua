return {
  "lervag/vimtex",
  lazy = true, -- lazy-loading will disable inverse search
  ft = { "tex", "sty" },
  config = function()
    vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
    vim.g.vimtex_quickfix_method = vim.fn.executable "pplatex" == 1 and "pplatex" or "latexlog"
    -- vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "okular"
    vim.g.vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"
    vim.g.maplocalleader = " "
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
    vim.o.foldtext = "vimtex#fold#text()"
    vim.o.foldlevel = 2
  end,
}
