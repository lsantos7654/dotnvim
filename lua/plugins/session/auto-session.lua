return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		require("auto-session").setup({
			log_level = "error",
			-- auto_session_enabled = true,
			auto_save = true,
			auto_restore = true,
			auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		})
	end,
}
