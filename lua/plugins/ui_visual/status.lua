return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local colors = {
			fg = "#abb2bf",
			bg = "NONE",
			green = "#98c379",
			yellow = "#e5c07b",
			purple = "#c678dd",
			orange = "#d19a66",
			peanut = "#f6d5a4",
			red = "#e06c75",
			aqua = "#61afef",
			dark_red = "#f75f5f",
		}

		local custom_theme = {
			normal = {
				a = { fg = colors.green, bg = colors.bg, gui = "bold" },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
			insert = {
				a = { fg = colors.yellow, bg = colors.bg, gui = "bold" },
			},
			visual = {
				a = { fg = colors.purple, bg = colors.bg, gui = "bold" },
			},
			replace = {
				a = { fg = colors.red, bg = colors.bg, gui = "bold" },
			},
			command = {
				a = { fg = colors.aqua, bg = colors.bg, gui = "bold" },
			},
			inactive = {
				a = { fg = colors.fg, bg = colors.bg },
				b = { fg = colors.fg, bg = colors.bg },
				c = { fg = colors.fg, bg = colors.bg },
			},
		}

		require("lualine").setup({
			options = {
				theme = custom_theme,
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", color = { fg = colors.peanut, gui = "bold" } },
					{
						"diff",
						colored = true,
						diff_color = {
							added = { fg = colors.green },
							modified = { fg = colors.fg },
							removed = { fg = colors.red },
						},
					},
				},
				lualine_c = {},
				lualine_x = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, client in ipairs(clients) do
								table.insert(names, client.name)
							end
							return table.concat(names, ", ")
						end,
						color = { fg = colors.purple, gui = "bold" },
					},
				},
				lualine_y = {
					{ "filetype", colored = true, color = { fg = colors.red, gui = "bold" } },
				},
				lualine_z = {
					{ "progress", color = { fg = colors.aqua, gui = "bold" } },
				},
			},
			inactive_sections = {
				lualine_a = { "mode" },
				lualine_b = {
					{ "branch", color = { fg = colors.peanut, gui = "bold" } },
					{ "diff" },
				},
				lualine_c = {},
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { "progress" },
			},
		})
	end,
}
