local ls = require "luasnip"
local p = ls.parser.parse_snippet

return {
  p("ifer", "if err != nil {\n\t${1:// handle error}\n}$0"),
}
