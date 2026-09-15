-- Default configuration for custom PDF conversion
local DEFAULT_FONTS = {
  font = "Noto Serif",
  sans = "Noto Sans",
  mono = "DejaVu Sans Mono",
}

-- Generic asynchronous runner and helper function
local function run_converter(cmd, target_ext)
  local buf_name = vim.api.nvim_buf_get_name(0)

  if buf_name == "" or not buf_name:match "%.ipynb$" then
    vim.notify("Current buffer is not an .ipynb file", vim.log.levels.ERROR)
    return
  end

  vim.notify("Starting conversion...", vim.log.levels.INFO)

  vim.system(cmd, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        local output_name = buf_name:gsub("%.ipynb$", target_ext)
        vim.notify("Successfully created:\n" .. output_name, vim.log.levels.INFO)
      else
        local err_msg = obj.stderr ~= "" and obj.stderr or obj.stdout
        vim.notify("Conversion error:\n" .. err_msg, vim.log.levels.ERROR)
      end
    end)
  end)
end

local mono_font_flag = "--mono-font"
local sans_font_flag = "--sans-font"
local main_font_flag = "--font"
local no_font_flag = "--no-fonts"

local ipynb2pdf = function(opts)
  local buf_name = vim.api.nvim_buf_get_name(0)
  local script_path = vim.fn.expand "~/.config/nvim/utils/ipynb2pdf"

  if vim.fn.executable(script_path) ~= 1 then
    vim.notify("Script not found or not executable: " .. script_path, vim.log.levels.ERROR)
    return
  end

  local cmd = { script_path, buf_name }
  local user_args = vim.split(opts.args, "%s+", { trimempty = true })
  local skip_defaults = false

  for _, arg in ipairs(user_args) do
    if arg == no_font_flag then
      skip_defaults = true
    else
      table.insert(cmd, arg)
    end
  end

  if not skip_defaults then
    if DEFAULT_FONTS.font and not vim.tbl_contains(cmd, main_font_flag) then
      table.insert(cmd, "--font")
      table.insert(cmd, DEFAULT_FONTS.font)
    end
    if DEFAULT_FONTS.sans and not vim.tbl_contains(cmd, sans_font_flag) then
      table.insert(cmd, "--sans-font")
      table.insert(cmd, DEFAULT_FONTS.sans)
    end
    if DEFAULT_FONTS.mono and not vim.tbl_contains(cmd, mono_font_flag) then
      table.insert(cmd, "--mono-font")
      table.insert(cmd, DEFAULT_FONTS.mono)
    end
  end

  run_converter(cmd, ".pdf")
end

vim.api.nvim_create_user_command("Ipynb2Pdf", function(opts)
  ipynb2pdf(opts)
end, {
  nargs = "*",
  desc = "Convert Jupyter Notebook to PDF using custom ipynb2pdf script",
  complete = function()
    return { "--execute", main_font_flag, sans_font_flag, mono_font_flag, "--keep-tmp", "--no-fonts" }
  end,
})

local std_converts = {
  Ipynb2Html = { fmt = "html", ext = ".html" },
  Ipynb2Webpdf = { fmt = "webpdf", ext = ".pdf" },
  Ipynb2Tex = { fmt = "latex", ext = ".tex" },
}

for cmd_name, cfg in pairs(std_converts) do
  vim.api.nvim_create_user_command(cmd_name, function(opts)
    local buf_name = vim.api.nvim_buf_get_name(0)
    local cmd = { "jupyter", "nbconvert", "--to", cfg.fmt, buf_name }

    if opts.args ~= "" then
      local user_args = vim.split(opts.args, "%s+", { trimempty = true })
      for _, arg in ipairs(user_args) do
        table.insert(cmd, arg)
      end
    end

    run_converter(cmd, cfg.ext)
  end, {
    nargs = "*",
    desc = string.format("Convert Jupyter Notebook to %s via nbconvert", cfg.fmt),
    complete = function()
      return { "--execute" }
    end,
  })
end
