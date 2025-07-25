return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  lazy = true,
  event = "VeryLazy",
  -- stylua: ignore
  config = function()
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd [[messages clear]]
    end

    local noice = require "noice"
    local map = vim.keymap.set

    noice.setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = {
        auto_open = {
          enabled = false,
        },
      },
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  })

    map("c", "<S-Enter>", function() noice.redirect(vim.fn.getcmdline()) end, { desc = "Redirect Cmdline" })
    map("n",  "<leader>nl", function() noice.cmd("last") end, { desc = "Noice Last Message" })
    map("n",  "<leader>nh", function() noice.cmd("history") end, { desc = "Noice History" })
    map("n",  "<leader>nn", function() noice.cmd("all") end, { desc = "Noice Messages" })
    map("n",  "<leader>nd", function() noice.cmd("dismiss") end, { desc = "Noice Dismiss All" })
    map("n",  "<leader>np", function() noice.cmd("pick") end, { desc = "Noice Picker" })
    map({ "i", "n", "s" }, "<c-f>", function() if not noice.lsp.scroll(4) then return "<c-f>" end end, { silent = true, expr = true, desc = "Scroll Forward" })
    map({ "i", "n", "s" }, "<c-b>", function() if not noice.lsp.scroll(-4) then return "<c-b>" end end,{ silent = true, expr = true, desc = "Scroll Backward" })
  end,
}
