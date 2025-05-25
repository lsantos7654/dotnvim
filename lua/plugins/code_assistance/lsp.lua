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
		-- Enhanced diagnostics configuration
		vim.diagnostic.config({
			virtual_text = {
				spacing = 4,
				prefix = "●",
			},
			signs = true,
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		-- Customize diagnostic signs
		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Use mason-lspconfig to automatically setup servers
		require("mason-lspconfig").setup({
			handlers = {
				-- Default handler - uses vim.lsp.enable
				function(server_name)
					-- Enable the server with default config
					vim.lsp.enable(server_name)
				end,

				-- Custom configurations for specific servers
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

				bzl = function()
					vim.lsp.config("bzl", {
						root_dir = require("lspconfig.util").root_pattern(
							"MODULE.bazel",
							"WORKSPACE",
							"WORKSPACE.bazel",
							".git"
						),
					})
					vim.lsp.enable("bzl")
				end,
			},
		})
	end,
}
