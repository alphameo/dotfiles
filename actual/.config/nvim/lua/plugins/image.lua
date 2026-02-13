return {
  "3rd/image.nvim",
  lazy = true,
  ft = { "markdown" },
  config = function()
    local img = require "image"
    img.setup {
      backend = "kitty",
      max_width = 128,
      max_height = 16,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      integrations = {
        markdown = {
          only_render_image_at_cursor = false, -- defaults to false
          only_render_image_at_cursor_mode = "popup", -- "popup" or "inline", defaults to "popup"
        },
      },
    }

    local toggle_img = function()
      if require("image").is_enabled() then
        require("image").disable()
        vim.notify("Images disabled", vim.log.levels.INFO)
      else
        require("image").enable()
        vim.notify("Images enabled", vim.log.levels.INFO)
      end
    end
    vim.keymap.set("n", "\\i", toggle_img, { desc = "Toggle Image Previews" })
  end,
}
