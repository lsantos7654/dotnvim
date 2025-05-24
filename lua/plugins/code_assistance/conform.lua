return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		-- Map of filetype to formatters
		formatters_by_ft = {
			-- Lua
			lua = { "stylua" },

			-- Python - smart selection between ruff and black/isort
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,

			-- JavaScript/TypeScript
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },

			-- Web Technologies
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			yml = { "prettier" },

			-- Shell Scripts
			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },

			-- C/C++
			c = { "clang_format" },
			cpp = { "clang_format" },

			-- Bazel
			bzl = { "buildifier" },

			-- Markdown
			markdown = { "prettier" },

			-- Use the "*" filetype to run formatters on all filetypes
			["*"] = { "codespell" },

			-- Use the "_" filetype to run formatters on filetypes that don't have other formatters
			["_"] = { "trim_whitespace" },
		},

		-- Set this to change the default values when calling conform.format()
		default_format_opts = {
			lsp_format = "fallback",
		},

		-- Format on save configuration
		format_on_save = {
			-- I recommend these options. See :help conform.format for details.
			lsp_format = "fallback",
			timeout_ms = 500,
		},

		-- Async format after save (optional - can be useful for slow formatters)
		-- format_after_save = {
		-- 	lsp_format = "fallback",
		-- },

		-- Set the log level. Use `:ConformInfo` to see the location of the log file.
		log_level = vim.log.levels.ERROR,

		-- Conform will notify you when a formatter errors
		notify_on_error = true,

		-- Conform will notify you when no formatters are available for the buffer
		notify_no_formatters = false, -- Set to false to reduce noise

		-- Custom formatters and overrides for built-in formatters
		formatters = {
			-- Custom ruff formatter configuration
			ruff_format = {
				condition = function(self, ctx)
					-- Only use ruff if pyproject.toml exists or we're in a Python project
					return vim.fs.find({ "pyproject.toml", "ruff.toml", ".ruff.toml" }, {
						path = ctx.filename,
						upward = true,
					})[1] ~= nil
				end,
			},

			-- Custom stylua configuration
			stylua = {
				condition = function(self, ctx)
					-- Look for stylua.toml or .stylua.toml
					return vim.fs.find({ "stylua.toml", ".stylua.toml" }, {
						path = ctx.filename,
						upward = true,
					})[1] ~= nil or vim.bo[ctx.buf].filetype == "lua"
				end,
			},

			-- Custom prettier configuration
			prettier = {
				condition = function(self, ctx)
					-- Only use prettier if config exists or for web files
					local prettier_configs = {
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettierrc.cjs",
						"prettier.config.js",
						"prettier.config.cjs",
						"package.json",
					}
					return vim.fs.find(prettier_configs, {
						path = ctx.filename,
						upward = true,
					})[1] ~= nil
				end,
			},

			-- Custom shfmt configuration
			shfmt = {
				prepend_args = { "-i", "2" }, -- 2 space indentation
			},

			-- Custom clang-format configuration
			clang_format = {
				condition = function(self, ctx)
					-- Look for .clang-format file
					return vim.fs.find({ ".clang-format", "_clang-format" }, {
						path = ctx.filename,
						upward = true,
					})[1] ~= nil or vim.tbl_contains({ "c", "cpp", "objc", "objcpp" }, vim.bo[ctx.buf].filetype)
				end,
			},
		},
	},

	-- Additional configuration function
	config = function(_, opts)
		require("conform").setup(opts)

		-- Create user commands for manual formatting
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range })
		end, { range = true })

		-- Format command for specific formatter
		vim.api.nvim_create_user_command("FormatWith", function(args)
			require("conform").format({
				formatters = { args.args },
				async = true,
			})
		end, {
			nargs = 1,
			complete = function()
				return vim.tbl_keys(require("conform").list_all_formatters())
			end,
		})

		-- Add keymaps
		vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			require("conform").format({
				lsp_format = "fallback",
				async = true,
			})
		end, { desc = "Format code" })

		-- Optional: Format selection in visual mode
		vim.keymap.set("v", "<leader>fs", function()
			require("conform").format({
				lsp_format = "fallback",
				async = true,
			})
		end, { desc = "Format selection" })
	end,
}
