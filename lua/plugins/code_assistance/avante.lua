return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- 🤖 Primary AI Provider Configuration
		provider = "claude", -- Set Claude as the default provider
		-- provider = "deepseek",
		-- auto_suggestions_provider = "claude", -- Use Claude for auto-suggestions too

		system_prompt = function()
			local hub = require("mcphub").get_hub_instance()
			return hub and hub:get_active_servers_prompt() or ""
		end,
		-- Using function prevents requiring mcphub before it's loaded
		custom_tools = function()
			return {
				require("mcphub.extensions.avante").mcp_tool(),
			}
		end,

		-- 🎯 Claude Configuration (Primary)
		claude = {
			endpoint = "https://api.anthropic.com",
			model = "claude-sonnet-4-20250514",
			temperature = 0,
			max_tokens = 8192, -- Increased for longer responses
			timeout = 30000, -- 30 second timeout
		},

		-- 💤 DeepSeek Configuration (Commented out but ready to use)
		-- Uncomment and change provider to "deepseek" to switch
		-- vendors = {
		-- 	["deepseek"] = {
		-- 		__inherited_from = "openai", -- Inherit OpenAI's base configuration
		-- 		api_key_name = "",
		-- 		endpoint = "http://deepseek-v3.clusters.corp.theaiinstitute.com/v1",
		-- 		model = "default",
		-- 		disable_tools = true,
		-- 	},
		-- },

		-- 🎛️ Enhanced Behavior Configuration
		behaviour = {
			auto_suggestions = false, -- Keep disabled for now (experimental)
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = true, -- Enable clipboard support
			minimize_diff = true,
			enable_token_counting = true,
		},

		-- ⌨️ Enhanced Mappings
		mappings = {
			ask = "<A-a>", -- Quick ask with Alt+a
			edit = "<A-e>", -- Quick edit with Alt+e

			-- Diff conflict resolution
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]x",
				prev = "[x",
			},

			-- AI suggestions
			suggestion = {
				accept = "<M-l>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},

			-- Navigation
			jump = {
				next = "]]",
				prev = "[[",
			},

			-- Submission
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},

			-- Cancellation
			cancel = {
				normal = { "<C-c>", "<Esc>", "q" },
				insert = { "<C-c>" },
			},

			-- Sidebar operations
			sidebar = {
				apply_all = "A",
				apply_cursor = "a",
				retry_user_request = "r",
				edit_user_request = "e",
				switch_windows = "<Tab>",
				reverse_switch_windows = "<S-Tab>",
				remove_file = "d",
				add_file = "@",
				close = { "<Esc>", "q" },
			},
		},

		-- 💡 Hints Configuration
		hints = {
			enabled = false, -- Keep hints enabled for better UX
		},

		-- 🪟 Enhanced Window Configuration
		windows = {
			position = "right", -- Sidebar on the right
			wrap = true,
			width = 35, -- Slightly wider for better readability
			sidebar_header = {
				enabled = true,
				align = "center",
				rounded = true,
			},
			input = {
				prefix = "> ", -- Changed from emoji to simple prompt
				height = 10, -- Taller input for longer prompts
			},
			edit = {
				border = "rounded",
				start_insert = true,
			},
			ask = {
				floating = false,
				start_insert = true,
				border = "rounded",
				focus_on_apply = "ours",
			},
		},

		-- 🎨 Highlighting Configuration
		highlights = {
			diff = {
				current = "DiffText",
				incoming = "DiffAdd",
			},
		},

		-- ⚔️ Diff Configuration
		diff = {
			autojump = true,
			list_opener = "copen",
			override_timeoutlen = 500,
		},

		-- 💭 Suggestion Configuration
		suggestion = {
			debounce = 600,
			throttle = 600,
		},

		-- 🔍 File Selector Configuration
		selector = {
			provider = "telescope", -- Use telescope for file selection
		},

		-- 🛠️ Tools Configuration
		-- disable_tools = false, -- Keep tools enabled for Claude

		-- 🌐 Web Search Configuration (Optional)
		-- web_search_engine = {
		-- 	provider = "tavily", -- Default web search provider
		-- 	-- proxy = nil, -- Add proxy if needed
		-- },
	},

	-- 🔨 Build Configuration
	build = "make", -- Standard build process
	-- build = "make BUILD_FROM_SOURCE=true", -- Uncomment for source build

	-- 📦 Dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua", -- For Copilot integration

		-- 📸 Image Support
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = { insert_mode = true },
					use_absolute_path = true,
				},
			},
		},

		-- 📝 Markdown Rendering
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "quarto", "Avante" }, -- Added Avante filetype
			},
			ft = { "markdown", "quarto", "Avante" },
		},
	},
}
