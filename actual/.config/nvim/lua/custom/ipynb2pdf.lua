-- Default configuration (customize fonts or set values to nil)
local DEFAULT_FONTS = {
  font = "Noto Serif",
  sans = "Noto Sans",
  mono = "DejaVu Sans Mono",
}

local ipynb2pdf = function(opts)
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == "" or not buf_name:match "%.ipynb$" then
    vim.notify("Current buffer is not an .ipynb file", vim.log.levels.ERROR)
    return
  end

  local script_path = vim.fn.expand "~/.config/nvim/utils/ipynb2pdf"
  if vim.fn.executable(script_path) ~= 1 then
    vim.notify("Script not found or not executable: " .. script_path, vim.log.levels.ERROR)
    return
  end

  local cmd = { script_path, buf_name }

  -- Parse user arguments
  local user_args = vim.split(opts.args, "%s+", { trimempty = true })
  local skip_defaults = false

  for _, arg in ipairs(user_args) do
    if arg == "--no-fonts" then
      skip_defaults = true
    else
      table.insert(cmd, arg)
    end
  end

  if not skip_defaults then
    if DEFAULT_FONTS.font and not vim.tbl_contains(cmd, "--font") then
      table.insert(cmd, "--font")
      table.insert(cmd, DEFAULT_FONTS.font)
    end
    if DEFAULT_FONTS.sans and not vim.tbl_contains(cmd, "--sans-font") then
      table.insert(cmd, "--sans-font")
      table.insert(cmd, DEFAULT_FONTS.sans)
    end
    if DEFAULT_FONTS.mono and not vim.tbl_contains(cmd, "--mono-font") then
      table.insert(cmd, "--mono-font")
      table.insert(cmd, DEFAULT_FONTS.mono)
    end
  end

  vim.notify("Starting PDF conversion...", vim.log.levels.INFO)

  vim.system(cmd, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        local pdf_name = buf_name:gsub("%.ipynb$", ".pdf")
        vim.notify("PDF successfully created:\n" .. pdf_name, vim.log.levels.INFO)
      else
        vim.notify("Conversion error:\n" .. (obj.stderr ~= "" and obj.stderr or obj.stdout), vim.log.levels.ERROR)
      end
    end)
  end)
end

vim.api.nvim_create_user_command("Ipynb2Pdf", function(opts)
  ipynb2pdf(opts)
end, {
  nargs = "*",
  desc = "Convert Jupyter Notebook to PDF using ipynb2pdf script",
  complete = function()
    return { "--execute", "--font", "--sans-font", "--mono-font", "--keep-tmp", "--no-fonts" }
  end,
})
