return {
	"rcarriga/nvim-notify",
	dependencies = "nvim-telescope/telescope.nvim",
	config = function(_, opts)
		require("notify").setup({
			timeout = 3000,
			background_colour = "#000000", -- or any other color you prefer
			stages = "fade_in_slide_out",
			render = "minimal",
			background_colour = "#000000",
			on_open = function(win)
				vim.api.nvim_win_set_config(win, { zindex = 100 })
			end,
			top_down = true,
		})
	end,
}
