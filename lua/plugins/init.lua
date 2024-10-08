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
	-- Editor Enhancements
	{
		-- Session Management
		require("plugins.session.nvim-lastplace"), -- Remember last cursor position in files
		require("plugins.session.auto-session"), -- Automatic session management for projects

		-- Navigation and Exploration
		require("plugins.navigation.nvimtree"), -- File explorer sidebar
		require("plugins.navigation.telescope"), -- Fuzzy finder for files, buffers, and more
		{
			"christoomey/vim-tmux-navigator",
			lazy = false,
		}, -- Seamless navigation between tmux panes and vim splits
	},

	-- UI and Visual Enhancements
	{
		require("plugins.ui_visual.treesitter"), -- Advanced syntax highlighting and code analysis
		require("plugins.ui_visual.codewindow"), -- Minimap-style code outline
		require("plugins.ui_visual.web-devicons"), -- File icons for various plugins
		require("plugins.ui_visual.noice"),  -- Enhance UI for commandline, messages, and popupmenu
		require("plugins.ui_visual.notify"), -- Fancy notification system
		require("plugins.ui_visual.tabs"),   -- Enhanced tab management
		require("plugins.ui_visual.blankline"), -- Show indentation guides
		require("plugins.ui_visual.whichkey"), -- Interactive keybinding helper
		require("plugins.ui_visual.status"), -- Customizable status line
		require("plugins.ui_visual.theme"),  -- Color scheme and theming
	},

	-- Development Tools
	{
		-- Version Control
		require("plugins.dev_tools.fugitive"), -- Git integration
		require("plugins.dev_tools.gitsigns"), -- Show git changes in the sign column

		-- Terminal Integration
		require("plugins.dev_tools.nvterm"), -- Better terminal integration
		{ "nvim-neotest/nvim-nio" },   -- Asynchronous I/O library (dependency for some plugins)

		-- Language Support
		require("plugins.dev_tools.luarocks"), -- LuaRocks package manager integration
		require("plugins.dev_tools.molten"), -- Jupyter Notebook integration in Neovim
		require("plugins.dev_tools.image"), -- Image viewing support within Neovim
	},

	-- Coding Assistance
	{
		-- Language Server Protocol (LSP)
		require("plugins.code_assistance.mason"), -- Manage LSP servers, linters, and formatters
		require("plugins.code_assistance.lsp"), -- LSP configuration
		require("plugins.code_assistance.lsp-zero"), -- Simplified LSP setup
		require("plugins.code_assistance.null-ls"), -- Simplified LSP setup

		-- Autocompletion
		require("plugins.code_assistance.cmp"), -- Intelligent code completion

		-- Coding Utilities
		require("plugins.code_assistance.avante"), -- AI Assistance (Default: Claude 3.5)
		require("plugins.code_assistance.comment"), -- Easy code commenting
		require("plugins.code_assistance.zen"), -- Distraction-free coding mode
	},
})
