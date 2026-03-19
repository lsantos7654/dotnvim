return {
	"jakewvincent/mkdnflow.nvim",
	config = function()
		require("mkdnflow").setup({
			filetypes = { markdown = true, rmd = true, quarto = true },
			links = {
				implicit_extension = nil,
				transform_on_create = function(text)
					text = text:gsub(" ", "_")
					return text
				end,
			},
			new_file_template = {
				template = "# {{ title }}",
			},
			cursor = {
				jump_patterns = nil,
			},
			bib = {
				default_path = nil,
			},
			foldtext = {
				object_count_opts = function()
					return require("mkdnflow").foldtext.default_count_opts()
				end,
				title_transformer = nil,
			},
			mappings = {
				MkdnEnter = { { "n", "i" }, "<CR>" },
				MkdnTab = false,
				MkdnSTab = false,
				MkdnNextLink = false,
				MkdnPrevLink = false,
				MkdnNextHeading = { "n", "]]" },
				MkdnPrevHeading = { "n", "[[" },
				MkdnGoBack = false,
				MkdnGoForward = false,
				MkdnCreateLink = false,
				MkdnCreateLinkFromClipboard = false,
				MkdnFollowLink = false,
				MkdnDestroyLink = false,
				MkdnTagSpan = false,
				MkdnMoveSource = false,
				MkdnYankAnchorLink = false,
				MkdnYankFileAnchorLink = false,
				MkdnIncreaseHeading = { "n", "+" },
				MkdnDecreaseHeading = { "n", "-" },
				MkdnToggleToDo = { { "n", "v" }, "<M-m>" },
				MkdnNewListItem = false,
				MkdnNewListItemBelowInsert = { "n", "o" },
				MkdnNewListItemAboveInsert = { "n", "O" },
				MkdnExtendList = false,
				MkdnUpdateNumbering = false,
				MkdnTableNextCell = false,
				MkdnTablePrevCell = false,
				MkdnTableNextRow = false,
				MkdnTablePrevRow = false,
				MkdnTableNewRowBelow = { "n", "<leader>ir" },
				MkdnTableNewRowAbove = { "n", "<leader>iR" },
				MkdnTableNewColAfter = { "n", "<leader>ic" },
				MkdnTableNewColBefore = { "n", "<leader>iC" },
				MkdnFoldSection = false,
				MkdnUnfoldSection = false,
			},
		})
	end,
}
