return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = { "python", "lua", "cpp", "json", "sh", "bash", "zsh" },
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = {
				-- Python Setup
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.diagnostics.ruff,
				-- null_ls.builtins.diagnostics.pyright,

				-- Lua Setup
				null_ls.builtins.formatting.stylua,

				-- C++
				null_ls.builtins.formatting.clang_format,

				-- Json
				null_ls.builtins.formatting.fixjson,

				-- bash
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.shfmt,

				-- HTML
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "html", "css", "javascript", "typescript", "json" },
				}),
			}
			return opts
		end,
	},
}
