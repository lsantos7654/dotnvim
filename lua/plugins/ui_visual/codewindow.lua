return {
	"gorbit99/codewindow.nvim",
	event = "VeryLazy",
	config = function()
		require("codewindow").setup({
			auto_enable = false,
			screen_bounds = "background",
			window_border = "solid",
		})
	end,
}
