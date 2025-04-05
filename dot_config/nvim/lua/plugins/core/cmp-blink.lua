return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "scroll_documentation_up", "show_signature", "hide_signature", "fallback" },
      ["<C-j>"] = { "select_next", "scroll_documentation_down", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-S-k>"] = { "show_documentation", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
    },

    signature = {
      enabled = true,
    },
    appearance = {
      -- "mono" | "normal"
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = true,
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "kind" },
            {
              "label",
              "label_description",
            },
            { "source_id" },
          },
        },
      },
    },

    cmdline = {
      completion = { menu = { auto_show = true } },
    },

    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "omni",
        -- "cmdline",
      },
      providers = {},
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
