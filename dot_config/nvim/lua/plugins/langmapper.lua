return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 1, -- High priority is needed if you will use `autoremap()`
  config = function()
    local langmapper = require "langmapper"

    langmapper.setup {}
    langmapper.automapping { global = true, buffer = true }
  end,
}
