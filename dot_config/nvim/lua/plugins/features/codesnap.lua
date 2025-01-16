return {
  "mistricky/codesnap.nvim",
  build = "make build_generator",
  keys = {
    { "<leader>cc", ":CodeSnap<cr>", mode = "x", silent = true, desc = "Save selected code snapshot into clipboard" },
    {
      "<leader>cS",
      ":CodeSnapSave<cr>",
      mode = "x",
      silent = true,
      desc = "Save selected code snapshot",
    },
  },
  opts = {
    mac_window_bar = true,
    title = "CodeSnap.nvim",
    code_font_family = "FiraCode Nerd Font",
    watermark_font_family = "Pacifico",
    watermark = "alphameo",
    bg_theme = "default", -- bamboo | sea | peach | grape | dusl | summer
    breadcrumbs_separator = "/",
    has_breadcrumbs = true,
    has_line_number = true,
    show_workspace = false,
    min_width = 0,
    bg_x_padding = 122,
    bg_y_padding = 82,
    save_path = os.getenv "HOME" .. "/Media/Pictures/Screenshots/Laptop_screenshots/Code",
  },
}
