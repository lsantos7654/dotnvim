return {
	"feline-nvim/feline.nvim",
	config = function()
		local feline = require("feline")

		local one_monokai = {
			fg = "#abb2bf",
			bg = "NONE",
			green = "#98c379",
			yellow = "#e5c07b",
			purple = "#c678dd",
			orange = "#d19a66",
			peanut = "#f6d5a4",
			red = "#e06c75",
			aqua = "#61afef",
			darkblue = "NONE",
			dark_red = "#f75f5f",
		}

		local vi_mode_colors = {
			NORMAL = "green",
			OP = "green",
			INSERT = "yellow",
			VISUAL = "purple",
			LINES = "orange",
			BLOCK = "dark_red",
			REPLACE = "red",
			COMMAND = "aqua",
		}

		local c = {
			vim_mode = {
				provider = {
					name = "vi_mode",
					opts = {
						show_mode_name = true,
					},
				},
				hl = function()
					return {
						fg = require("feline.providers.vi_mode").get_mode_color(),
						bg = "NONE",
						style = "bold",
						name = "NeovimModeHLColor",
					}
				end,
				left_sep = " ",
				right_sep = " ",
			},
			gitBranch = {
				provider = "git_branch",
				hl = {
					fg = "peanut",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			gitDiffAdded = {
				provider = "git_diff_added",
				hl = {
					fg = "green",
					bg = "NONE",
				},
				left_sep = " ",
				right_sep = " ",
			},
			gitDiffRemoved = {
				provider = "git_diff_removed",
				hl = {
					fg = "red",
					bg = "NONE",
				},
				left_sep = " ",
				right_sep = " ",
			},
			gitDiffChanged = {
				provider = "git_diff_changed",
				hl = {
					fg = "fg",
					bg = "NONE",
				},
				left_sep = " ",
				right_sep = " ",
			},
			lsp_client_names = {
				provider = "lsp_client_names",
				hl = {
					fg = "purple",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			file_type = {
				provider = {
					name = "file_type",
					opts = {
						filetype_icon = true,
						case = "titlecase",
					},
				},
				hl = {
					fg = "red",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			position = {
				provider = "position",
				hl = {
					fg = "green",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
			line_percentage = {
				provider = "line_percentage",
				hl = {
					fg = "aqua",
					bg = "NONE",
					style = "bold",
				},
				left_sep = " ",
				right_sep = " ",
			},
		}

		local left = {
			c.vim_mode,
			c.gitBranch,
			c.gitDiffAdded,
			c.gitDiffRemoved,
			c.gitDiffChanged,
		}

		local right = {
			c.lsp_client_names,
			c.file_type,
			c.position,
			c.line_percentage,
		}

		local components = {
			active = {
				left,
				{}, -- Empty middle section
				right,
			},
			inactive = {
				left,
				{}, -- Empty middle section
				right,
			},
		}

		feline.setup({
			components = components,
			theme = one_monokai,
			vi_mode_colors = vi_mode_colors,
		})
	end,
}
