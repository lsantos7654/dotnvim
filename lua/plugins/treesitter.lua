return {
	{
	  "nvim-treesitter/nvim-treesitter",
	  build = ":TSUpdate",
	  config = function()
		require("nvim-treesitter.configs").setup({
		  ensure_installed = { "lua", "python" , "markdown", "markdown_inline"},  -- Add other languages you need
		  highlight = {
		enable = true,
		  },
		})
	  end,
	}
}
