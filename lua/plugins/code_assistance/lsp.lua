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
		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				prefix = "●",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Use mason-lspconfig to automatically setup servers
		require("mason-lspconfig").setup({
			handlers = {
				-- Default handler - uses vim.lsp.enable
				function(server_name)
					-- Enable the server with default config
					vim.lsp.enable(server_name)
				end,

				-- Custom configurations for specific servers
				stylua = function() end, -- formatter only, handled by conform.nvim

			lua_ls = function()
					vim.lsp.config("lua_ls", {
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = {
									enable = false,
								},
							},
						},
					})
					vim.lsp.enable("lua_ls")
				end,

				-- bzl = function()
				-- 	vim.lsp.config("bzl", {
				-- 		root_dir = require("lspconfig.util").root_pattern(
				-- 			"MODULE.bazel",
				-- 			"WORKSPACE",
				-- 			"WORKSPACE.bazel",
				-- 			".git"
				-- 		),
				-- 	})
				-- 	vim.lsp.enable("bzl")
				-- end,
			},
		})
	end,
}
