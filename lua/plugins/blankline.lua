return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			highlight = { "IBLIndent1", "IBLIndent2" },
			char = "▏",
		},
		scope = {
			highlight = { "IBLScope" },
			show_start = false,
			show_end = false,
		},
	},
	config = function(_, opts)
		local hooks = require("ibl.hooks")

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- Snowy gray indents
			vim.api.nvim_set_hl(0, "IBLIndent1", { fg = "#D0D0D0" })
			vim.api.nvim_set_hl(0, "IBLIndent2", { fg = "#C0C0C0" })

			-- Light blue for current scope
			vim.api.nvim_set_hl(0, "IBLScope", { fg = "#80BFFF" })
			-- Green for current scope (changed from light blue)
			-- vim.api.nvim_set_hl(0, "IBLScope", { fg = "#80FF80" })
		end)

		require("ibl").setup(opts)

		-- Register the scope highlight hook
		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
