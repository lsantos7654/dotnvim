return {
	"3rd/image.nvim",
	build = false, -- Disable rock building
	opts = {
		processor = "magick_cli", -- Use CLI instead of rock
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				filetypes = { "markdown", "vimwiki", "quarto" },
			},
		},
		max_width = 100,
		max_height = 30,
		max_height_window_percentage = math.huge,
		max_width_window_percentage = math.huge,
		window_overlap_clear_enabled = true,
		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	},
}
