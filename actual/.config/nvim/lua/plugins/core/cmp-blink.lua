return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    version = "1.*",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = {
        preset = "default",
        ["<C-space>"] = { "show", "hide", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-d>"] = { "show_documentation", "hide_documentation", "fallback" },
        ["<C-s>"] = { "show_signature", "hide_signature" }, -- replace default signature
        ["<C-e>"] = { "scroll_documentation_down", "fallback" },
        ["<C-y>"] = { "scroll_documentation_up", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "fallback",
        },
        ["<C-Tab>"] = { "snippet_forward", "fallback" },
        ["<C-S-Tab>"] = { "snippet_backward", "fallback" },
      },
      completion = {
        menu = {
          enabled = true,
          auto_show = true,
          auto_show_delay_ms = 0,
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "kind" },
              { "label", "label_description" },
              { "source_id" },
            },
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = false },
      },
      signature = {
        enabled = true,
        trigger = { enabled = true },
        window = { show_documentation = true },
      },
      snippets = { preset = "luasnip" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          sql = { "lsp", "sql", "dadbod", "path", "snippets", "buffer" },
          tex = { "lsp", "latex", "path", "snippets", "buffer" },
          sty = { "lsp", "latex", "path", "snippets", "buffer" },
        },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          sql = {
            name = "sql",
            module = "blink.compat.source",
            score_offset = 3,
            opts = {},
          },
          latex = {
            name = "Latex",
            module = "blink-cmp-latex",
            opts = {
              insert_command = false, -- set to true to insert the latex command instead of the symbol
            },
          },
        },
      },
      fuzzy = {
        frecency = { enabled = true },
        use_proximity = true,
      },
      cmdline = {
        enabled = true,
        keymap = {
          ["<C-Space>"] = { "show", "hide", "fallback" },
          ["<Tab>"] = { "accept", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
        },
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = false },
          list = {
            selection = {
              preselect = true,
              auto_insert = false,
            },
          },
        },
      },
      term = {
        enabled = false,
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = false },
          list = {
            selection = {
              preselect = true,
              auto_insert = false,
            },
          },
        },
      },
      appearance = {
        nerd_font_variant = "mono", -- "mono" | "normal"
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "saghen/blink.compat",
    version = "2.*", -- use v2.* for blink.cmp v1.*
    lazy = true,
    opts = {},
  },
}
