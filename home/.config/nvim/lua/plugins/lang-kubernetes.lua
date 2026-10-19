return {
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm",
    opts = {
      conceal_templates = {
        -- replacement of templates with virtual text of their current values
        -- note: for better wrapping support, set `vim.opt.conceallevel = 2`
        enabled = true,
      },
      indent_hints = {
        enabled = true,
        only_for_current_line = true,
      },
      action_highlight = {
        enabled = true, -- highlighting of the current block
      },
    },
  },
}
