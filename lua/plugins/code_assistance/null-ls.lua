return {
	"jose-elias-alvarez/null-ls.nvim",
	ft = { "python", "lua", "cpp", "json", "yaml", "sh", "bash", "zsh", "javascript" },
	opts = function(_, opts)
		local null_ls = require("null-ls")
		opts.sources = {
			-- Python Setup
			null_ls.builtins.formatting.black,

			-- Lua Setup
			null_ls.builtins.formatting.stylua,

			-- C++
			null_ls.builtins.formatting.clang_format,

			-- Json
			null_ls.builtins.formatting.fixjson,

			-- bash
			null_ls.builtins.diagnostics.shellcheck,
			null_ls.builtins.formatting.shfmt,

			-- HTML, CSS, JavaScript, TypeScript, JSON
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "html", "css", "javascript", "typescript", "json", "yaml" },
			}),

			-- JavaScript specific
			null_ls.builtins.diagnostics.eslint,
			null_ls.builtins.formatting.prettier.with({
				filetypes = { "javascript" },
			}),
		}
		return opts
	end,
}
