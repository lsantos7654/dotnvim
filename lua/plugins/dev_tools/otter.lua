return {
	"jmbuhr/otter.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("otter").setup({
			lsp = {
				-- More frequent diagnostic updates for better responsiveness
				diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
				-- function to find the root dir where the otter-ls is started
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, {
						".git",
						"_quarto.yml",
						"package.json",
						"pyproject.toml",
						"requirements.txt",
					}) or vim.fn.getcwd(0)
				end,
			},
			buffers = {
				-- IMPORTANT: Set this to true for proper LSP functionality
				set_filetype = true,
				-- Write to disk for linters that need actual files
				write_to_disk = false,
				-- Handle leading whitespace properly
			},
			-- Remove quote characters that might interfere
			strip_wrapping_quote_characters = { "'", '"', "`" },
			-- Handle indentation properly in code blocks
			handle_leading_whitespace = true,
			-- Enable verbose warnings to debug issues
			verbose = {
				no_code_found = true, -- This will warn if no code is found
			},
		})
	end,
}
