return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 0.95,
			width = 120,
			height = 1,
			options = {
				signcolumn = "no",
				number = false,
				relativenumber = false,
				cursorline = false,
				cursorcolumn = false,
				foldcolumn = "0",
				list = false,
			},
		},
		plugins = {
			options = {
				enabled = true,
				ruler = false,
				showcmd = false,
				laststatus = 0,
			},
			twilight = { enabled = false },
			gitsigns = { enabled = true },
			tmux = { enabled = true },
			kitty = {
				enabled = true,
				font = "+0",
			},
		},
		on_open = function(win)
			-- Custom code when Zen window opens
		end,
		on_close = function()
			-- Custom code when Zen window closes
		end,
	},
}
