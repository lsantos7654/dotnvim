-- General settings
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.g.mapleader = " " -- Set leader key to space

-- spellchecking
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

-- Set search to ignore case
vim.opt.ignorecase = true

-- Enable smart case sensitivity
vim.opt.smartcase = true

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Indentation settings
vim.opt.tabstop = 2 -- Number of spaces a TAB counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for auto-indenting
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while editing

-- Line numbering
vim.wo.number = true -- Show line numbers
vim.wo.relativenumber = true -- Show relative line numbers

-- Appearance
-- vim.opt.transparent = true  -- Uncomment to enable transparency
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })
vim.opt.laststatus = 3 -- Global statusline

-- Custom highlights
vim.cmd([[highlight NotifyBackground guibg=#000000]])

-- -- File type associations
vim.filetype.add({
	extension = {
		qmd = "markdown",
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "quarto", "markdown" }, -- Add the filetypes you want to use otter with
	callback = function()
		require("otter").activate()
	end,
})
vim.treesitter.language.register("markdown", { "quarto", "rmd" })

-- LSP hover handler
vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
	config = config or {}
	config.focus_id = ctx.method
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

-- Folding configuration
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.opt.fillchars = { fold = "·" }
vim.opt.foldcolumn = "0"
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 3
vim.opt.foldminlines = 1
vim.cmd([[highlight Folded guibg=#2d3149 guifg=#a9b1d6]])
