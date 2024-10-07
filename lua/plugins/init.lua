-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy and plugins
require("lazy").setup({
	-- Session management
	require("plugins.nvim-lastplace"), -- Remember last editing position
	require("plugins.auto-session"), -- Automatic session management

	-- IDE-like features
	require("plugins.treesitter"), -- Better syntax highlighting and code understanding
	require("plugins.nvimtree"), -- File explorer
	require("plugins.web-devicons"), -- Icons for nvim-tree and other plugins
	require("plugins.telescope"), -- Fuzzy finder and more
	{ "nvim-neotest/nvim-nio" }, -- Asynchronous I/O operations
	require("plugins.nvterm"), -- Terminal setup

	-- UI enhancements
	require("plugins.noice"), -- Replaces UI for cmdline, messages, and popupmenu
	require("plugins.notify"), -- Notification system
	require("plugins.avante"), -- Custom UI enhancements
	require("plugins.tabs"), -- Tab management
	require("plugins.blankline"), -- Indentation guides
	require("plugins.whichkey"), -- Helper for keybindings
	require("plugins.codewindow"), -- Terminal code window
	require("plugins.status"), -- Status line

	-- File type specific
	require("plugins.molten"), -- Jupyter Notebook integration
	require("plugins.image"), -- Image viewing support

	-- Utility
	require("plugins.luarocks"), -- LuaRocks package manager integration
	require("plugins.fugitive"), -- Git integration
	require("plugins.gitsigns"), -- Git signs on tab
	require("plugins.comment"), -- Easy code commenting
	require("plugins.zen"), -- Easy code commenting

	-- Navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	}, -- Seamless navigation between tmux panes and vim splits

	-- LSP (Language Server Protocol)
	require("plugins.null-ls"), -- Use Neovim as a language server
	require("plugins.mason"), -- Package manager for LSP servers, DAP servers, linters, and formatters
	require("plugins.lsp"), -- LSP configuration
	require("plugins.lsp-zero"), -- Easy LSP setup

	-- Autocompletion
	require("plugins.cmp"), -- Autocompletion plugin
})
