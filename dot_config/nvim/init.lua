require("core.options")
require("core.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	require("plugins.themes.onedark"),
	require("plugins.themes.greetingscreen"),
	require("plugins.neo-tree"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.indent-blankline"),
	require("plugins.tab-detection"),
	require("plugins.todo-comments"),
	require("plugins.colorizer"),
	require("plugins.which-key"),
	require("plugins.telescope"),
	require("plugins.harpoon"),
	require("plugins.treesitter"),
	require("plugins.lsp"),
	require("plugins.surround"),
	require("plugins.cmp"),
	require("plugins.fmt"),
	require("plugins.dap"),
	require("plugins.autopairs"),
	require("plugins.git"),
	require("plugins.ts-autotags"),
	require("plugins.lsp-pref.lsp-java"),
})
