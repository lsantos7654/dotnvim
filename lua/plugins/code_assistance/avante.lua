return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	opts = {
		provider = "deepseek", -- Set this as the default provider
		mappings = {
			ask = "<A-a>",
			edit = "<A-e>",
		},
		hints = { enabled = false },
		vendors = {
			["deepseek"] = {
				__inherited_from = "openai", -- Inherit OpenAI's base configuration
				endpoint = "http://deepseek-r1.clusters.corp.theaiinstitute.com/v1",
				model = "default",
				api_key = "EMPTY",
				timeout = 30000,
				temperature = 0.3,
				max_tokens = 4096,
			},
		},
	},
	build = "make BUILD_FROM_SOURCE=true",
	-- build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = { file_types = { "markdown", "quarto" } },
			ft = { "markdown", "quarto" },
		},
	},
}
