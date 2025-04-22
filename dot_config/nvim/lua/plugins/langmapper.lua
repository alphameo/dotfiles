return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 1001,
  config = function()
    local langmapper = require "langmapper"

    langmapper.setup {}
    langmapper.automapping { global = true, buffer = true }

    local function escape(str)
      local escape_chars = [[;,."|\]]
      return vim.fn.escape(str, escape_chars)
    end

    local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
    local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
    local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
    local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

    vim.opt.langmap = vim.fn.join({
      escape(ru_shift) .. ";" .. escape(en_shift),
      escape(ru) .. ";" .. escape(en),
    }, ",")
  end,
}
