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
	require("plugins.appearance.onedark-theme"),
	require("plugins.appearance.greetingscreen"),
	require("plugins.appearance.colorizer"),
	require("plugins.appearance.bufferline"),
	require("plugins.appearance.lualine"),
	require("plugins.appearance.indent-blankline"),
	require("plugins.appearance.todo-comments"),
	require("plugins.main.treesitter"),
	require("plugins.main.lsp"),
	require("plugins.main.format"),
	require("plugins.main.dap"),
	require("plugins.main.completion"),
	require("plugins.main.code-runner"),
	require("plugins.features.autopairs"),
	require("plugins.features.tab-detection"),
	require("plugins.features.surround"),
	require("plugins.features.which-key"),
	require("plugins.features.git"),
	require("plugins.navigation.telescope"),
	require("plugins.navigation.harpoon"),
	require("plugins.navigation.neo-tree"),
})