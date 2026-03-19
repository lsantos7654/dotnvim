return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		arg = "leetcode.nvim",
		lang = "python",
		injector = {
			["python"] = { imports = {} },
		},
		picker = { provider = "telescope" },
	},
}
