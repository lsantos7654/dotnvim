return {
	"jmbuhr/otter.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("otter").setup({})
	end,
}
