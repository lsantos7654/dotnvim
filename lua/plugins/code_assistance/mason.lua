local options = {
	ensure_installed = {
		"pyright",
		"debugpy",
		"ruff-lsp",
		"mypy",
		"black",
		"stylua",
		"clangd",
		"clang-format",
		"codelldb",
		"lua-language-server",
		"json-lsp",
		"fixjson",
		"shellcheck",
		"shfmt",
		"bash-language-server",
		"eslint-lsp",
		"prettier",
		"html-lsp",
	},
	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},
		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
	max_concurrent_installers = 10,
}

return {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = options,
    config = function(_, opts)
        require("mason").setup(opts)

        -- custom cmd to install all mason binaries listed
        vim.api.nvim_create_user_command("MasonInstallAll", function()
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
            end
        end, {})

        vim.g.mason_binaries_list = opts.ensure_installed

        -- Auto-install configured servers
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyDone",
            callback = function()
                local registry = require("mason-registry")
                for _, tool in ipairs(opts.ensure_installed) do
                    if not registry.is_installed(tool) then
                        vim.cmd("MasonInstall " .. tool)
                    end
                end
            end,
        })
    end,
}