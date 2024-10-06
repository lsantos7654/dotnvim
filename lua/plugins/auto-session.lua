return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		auto_session_enable_last_session = true,
		auto_session_enabled = true,
		auto_save_enabled = true,
		auto_restore_enabled = true,
	},
}
