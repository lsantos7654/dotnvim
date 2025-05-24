-- General settings
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.g.mapleader = " " -- Set leader key to space

-- Performance improvements
vim.opt.updatetime = 300 -- Faster completion (default 4000ms)
vim.opt.timeoutlen = 500 -- Faster key sequence timeout
vim.opt.redrawtime = 10000 -- Allow more time for loading syntax on large files

-- Search settings
vim.opt.ignorecase = true -- Set search to ignore case
vim.opt.smartcase = true -- Enable smart case sensitivity
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show search matches as you type

-- Spellchecking
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Disable netrw (using nvim-tree instead)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation settings
vim.opt.tabstop = 2 -- Number of spaces a TAB counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for auto-indenting
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart autoindenting
vim.opt.breakindent = true -- Maintain indent when wrapping

-- Line numbering
vim.wo.number = true -- Show line numbers
vim.wo.relativenumber = true -- Show relative line numbers
vim.opt.signcolumn = "yes" -- Always show sign column to avoid text shifting

-- Scrolling and cursor
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.cursorline = true -- Highlight current line

-- Appearance
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })
vim.opt.laststatus = 3 -- Global statusline
vim.opt.showmode = false -- Don't show mode (status line shows it)
vim.opt.wrap = false -- Don't wrap lines
vim.opt.linebreak = true -- Break lines at word boundaries when wrap is on

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before overwriting
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undolevels = 10000 -- More undo levels

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Better completion experience
vim.opt.pumheight = 10 -- Maximum items in popup menu

-- Splits
vim.opt.splitbelow = true -- Horizontal splits below current window
vim.opt.splitright = true -- Vertical splits to the right

-- Custom highlights
vim.cmd([[highlight NotifyBackground guibg=#000000]])

-- 💾 Simple Save Notifications with File Icons & Size
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("SaveNotifications", { clear = true }),
	callback = function()
		local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
		local filepath = vim.api.nvim_buf_get_name(0)

		if filename == "" or filename == "[No Name]" then
			return
		end

		-- Get file icon from nvim-web-devicons
		local ok, devicons = pcall(require, "nvim-web-devicons")
		local icon = "💾"

		if ok then
			local file_icon = devicons.get_icon(filename, nil, { default = true })
			if file_icon then
				icon = file_icon
			end
		end

		-- Get file size
		local file_size = ""
		if vim.fn.filereadable(filepath) == 1 then
			local size = vim.fn.getfsize(filepath)
			if size > 0 then
				if size < 1024 then
					file_size = string.format(" (%dB)", size)
				elseif size < 1024 * 1024 then
					file_size = string.format(" (%.1fKB)", size / 1024)
				else
					file_size = string.format(" (%.1fMB)", size / 1024 / 1024)
				end
			end
		end

		-- Simple notification
		require("notify")(icon .. " " .. filename .. file_size, "info", {
			title = "Saved",
			timeout = 1500,
			render = "minimal",
		})
	end,
	desc = "Show simple save notification with file icon and size",
})

-- 📝 File type associations for Otter/Quarto
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "quarto", "rmd" },
	callback = function()
		-- Only activate otter if the plugin is available
		local ok, otter = pcall(require, "otter")
		if ok then
			otter.activate()
		end
	end,
	desc = "Activate Otter for Quarto/RMarkdown files",
})
vim.treesitter.language.register("markdown", { "quarto", "rmd" })

-- 🎨 CSV file handling
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.csv",
	callback = function()
		-- Only toggle if csvview is available
		local ok, _ = pcall(vim.cmd, "CsvViewToggle")
		if not ok then
			vim.notify("CsvView plugin not available", vim.log.levels.WARN)
		end
	end,
	desc = "Auto-enable CSV view for CSV files",
})

-- 🚀 LSP hover handler with better error handling
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = config or {}
	config.focus_id = ctx.method
	config.border = "rounded" -- Add rounded borders

	if not (result and result.contents) then
		return
	end

	local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
	markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)

	if vim.tbl_isempty(markdown_lines) then
		return
	end

	return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
end

-- 📁 Folding configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars = {
	fold = "·",
	eob = " ", -- Remove ~ from end of buffer
	vert = "│", -- Vertical split character
}
vim.opt.foldcolumn = "0"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.cmd([[highlight Folded guibg=#2d3149 guifg=#a9b1d6]])

-- 🔧 Auto-commands for better experience
local autocmd_group = vim.api.nvim_create_augroup("UserAutoCommands", { clear = true })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = autocmd_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
	desc = "Highlight yanked text",
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = autocmd_group,
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
	desc = "Remove trailing whitespace on save",
})

-- Auto-resize windows when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = autocmd_group,
	callback = function()
		vim.cmd("wincmd =")
	end,
	desc = "Auto-resize windows on terminal resize",
})

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = autocmd_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "Remember cursor position",
})
