return {
	"neovim/nvim-lspconfig",
	cmd = { "LspInfo", "LspInstall", "LspStart" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local lsp_zero = require("lsp-zero")

		lsp_zero.extend_lspconfig({
			sign_text = true,
			lsp_attach = lsp_attach,
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		require("mason-lspconfig").setup({
			ensure_installed = {},
			handlers = {
				-- Default handler
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,

				-- Specific bzl handler
				bzl = function()
					require("lspconfig").bzl.setup({
						root_dir = require("lspconfig.util").root_pattern(
							"MODULE.bazel",
							"WORKSPACE",
							"WORKSPACE.bazel",
							".git"
						),
					})
				end,
			},
		})
	end,
}
