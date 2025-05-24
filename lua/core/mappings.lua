local M = {}

function _G.highlight_code_chunk(from_current_position)
	local start_line, end_line

	if from_current_position then
		-- Search backwards for the start of the code block
		start_line = vim.fn.search("^```{python}", "bnW")
		-- If not found, we're not in a code chunk
		if start_line == 0 then
			return
		end
		-- Search forwards for the end of the code block
		end_line = vim.fn.search("^```$", "nW")
	else
		-- Move to the start of the code block
		start_line = vim.fn.search("^```{python}", "bc")
		end_line = vim.fn.search("^```$", "W")
	end

	-- Move to the first non-comment line
	local code_start_line = start_line
	while true do
		code_start_line = code_start_line + 1
		local line_content = vim.fn.getline(code_start_line)
		if not line_content:match("^%s*#") and line_content:match("%S") then
			break
		end
		if code_start_line >= end_line - 1 then
			-- If all lines are comments, don't highlight anything
			return
		end
	end

	-- Start visual mode from the first non-comment line
	vim.fn.cursor(code_start_line, 1)
	vim.cmd("normal! V")

	-- Move to the line before the end of the code block
	vim.fn.cursor(end_line - 1, 1)
end

function _G.goto_next_code_chunk()
	if vim.fn.mode():match("[vV]") then
		vim.cmd("normal! <Esc>")
	end

	vim.fn.search("^```$", "cW")
	if vim.fn.search("^```{python}", "W") ~= 0 then
		_G.highlight_code_chunk(false)
	end
end

function _G.goto_prev_code_chunk()
	if vim.fn.mode():match("[vV]") then
		vim.cmd("normal! <Esc>")
	end

	local current_pos = vim.fn.getcurpos()
	vim.fn.search("^```{python}", "bcW")

	if vim.fn.search("^```{python}", "bW") ~= 0 then
		_G.highlight_code_chunk(false)
	else
		vim.fn.setpos(".", current_pos)
	end
end

function _G.highlight_current_code_chunk()
	if vim.fn.mode():match("[vV]") then
		vim.cmd("normal! <Esc>")
	end

	_G.highlight_code_chunk(true)
end

M.qmd_python = {
	n = {
		["<leader>j"] = {
			":lua goto_next_code_chunk()<CR>zz",
			"Go to next code chunk",
			opts = { noremap = true, silent = true },
		},
		["<leader>k"] = {
			":lua goto_prev_code_chunk()<CR>zz",
			"Go to previous code chunk",
			opts = { noremap = true, silent = true },
		},
		["<leader>J"] = {
			":lua highlight_current_code_chunk()<CR>zz",
			"Highlight current code chunk",
			opts = { noremap = true, silent = true },
		},
	},
	v = {
		["<leader>j"] = {
			":lua goto_next_code_chunk()<CR>zz",
			"Go to next code chunk",
			opts = { noremap = true, silent = true },
		},
		["<leader>k"] = {
			":lua goto_prev_code_chunk()<CR>zz",
			"Go to previous code chunk",
			opts = { noremap = true, silent = true },
		},
	},
}

-- General mappings
M.general = {
	n = {
		-- Basic operations
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
		["<C-s>"] = { "<cmd> w <CR>", "Save file" },
		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"LSP formatting",
		},

		-- Window navigation
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },

		-- Cursor follows split
		["<C-w>v"] = { "<C-w>v<C-w>l", "Vertical Split" },
		["<C-w>s"] = { "<C-w>s<C-w>j", "Horizontal Split" },

		-- Custom Alt mappings
		["<M-h>"] = { "b", "Move to beginning of previous word" },
		["<M-l>"] = { "e", "Move to end of current word" },
		["H"] = { "^", "Move to next paragraph" },
		["L"] = { "$", "Move to end of current word" },
		["<M-j>"] = { "}", "Move to next paragraph" },
		["<M-k>"] = { "{", "Move to previous paragraph" },
		["<M-n>"] = { "%", "Move to matching bracket" },

		-- Line operations
		["P"] = { "<cmd>pu<CR>]==", "Paste below" },

		-- Additional mappings from paste-2.txt
		["<leader>s"] = { [[:%s/\v(<C-r><C-w>)//gIc<Left><Left><Left><Left>]], "Find and replace" },
		["n"] = { "nzzzv", "Next search result center screen" },
		["N"] = { "Nzzzv", "Previous search result center screen" },
		["<C-n>"] = { "<cmd>qall<CR>", "Quit Nvim" },
		["<leader>pd"] = { "<cmd>echo expand('%:p:h')<CR>", "Print file path" },
		["<leader>ll"] = { "<cmd>LspStart<CR>", "Start LSP service" },
		["<leader>lr"] = { "<cmd>LspRestart<CR>", "Start LSP restart" },
		["<leader>lp"] = { "<cmd>LspStop<CR>", "Stop LSP service" },
		["<A-d>"] = { "<C-e><C-e>", "Scroll window down" },
		["<A-u>"] = { "<C-y><C-y>", "Scroll window up" },
		["<leader>tl"] = { ":set number! relativenumber!<CR>", "Toggle line numbers" },
	},

	v = {
		-- Smart j and k: move by visual lines if wrapping is enabled
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },

		-- Indent and unindent selected lines
		["<Tab>"] = { ">gv", "Indent line" },
		["<S-Tab>"] = { "<gv", "Unindent line" },

		-- Window navigation
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },

		-- Quick navigation using Alt key
		["<M-h>"] = { "^", "Move to beginning of previous word" },
		["<M-l>"] = { "$", "Move to end of current word" },
		["<M-j>"] = { "}", "Move to next paragraph" },
		["<M-k>"] = { "{", "Move to previous paragraph" },
		["<M-n>"] = { "%", "Move to matching bracket" },

		-- Move selected text up and down
		["J"] = { ":m '>+1<CR>gv=gv", "Move text down" },
		["K"] = { ":m '<-2<CR>gv=gv", "Move text up" },

		-- Scroll window up and down
		["<A-d>"] = { "<C-e><C-e>", "Scroll window down" },
		["<A-u>"] = { "<C-y><C-y>", "Scroll window up" },

		-- Extras
		["<C-n>"] = { "<cmd>qall<CR>", "Quit Nvim" },

		-- Cursor follows split
		["<C-w>v"] = { "<C-w>v<C-w>l", "Vertical Split" },
		["<C-w>s"] = { "<C-w>s<C-w>j", "Horizontal Split" },
	},

	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Don't copy replaced text", opts = { silent = true } },
	},

	i = {
		["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
		["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
		["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
		["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },
		["<M-v>"] = { "<C-r>+", "Paste from clipboard" },
		["<Tab>"] = { "<C-t>", "Indent line" },
		["<S-Tab>"] = { "<C-d>", "Unindent line" },
		["<M-BS>"] = { "<C-o>db", "delete word (backward)" },
		["<M-d>"] = { "<C-o>dw", "delete word (backward)" },

		-- Line operations
		["<M-P>"] = { "<cmd>pu<CR>", "Paste below" },
		["<M-p>"] = { "<C-o>p", "Paste inline" },

		-- Custom Alt mappings
		["<M-h>"] = { "<C-o>h", "Move left 1" },
		["<M-l>"] = { "<C-o>l", "Move right 1" },
		["<M-j>"] = { "<C-o>j", "Move down 1" },
		["<M-k>"] = { "<C-o>k", "Move up 1" },
		["<M-n>"] = { "<C-o>%", "Move to matching bracket" },
		["<M-i>"] = { "<C-o>^", "Move to beginning of line" },
		["<M-a>"] = { "<C-o>$", "Move to end of line" },
	},
}

M.comment = {
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
	},
	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
	},
}

M.lspconfig = {
	n = {
		["gD"] = {
			function()
				vim.lsp.buf.declaration()
			end,
			"LSP declaration",
		},

		["gd"] = {
			function()
				vim.lsp.buf.definition()
			end,
			"LSP definition",
		},

		["K"] = {
			function()
				vim.lsp.buf.hover()
			end,
			"LSP hover",
		},

		["gi"] = {
			function()
				vim.lsp.buf.implementation()
			end,
			"LSP implementation",
		},

		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},

		["<leader>D"] = {
			function()
				vim.lsp.buf.type_definition()
			end,
			"LSP definition type",
		},

		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},

		["gr"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},

		["<leader>lf"] = {
			function()
				vim.diagnostic.open_float({ border = "rounded" })
			end,
			"Floating diagnostic",
		},

		["[d"] = {
			function()
				vim.diagnostic.goto_prev({ float = { border = "rounded" } })
			end,
			"Goto prev diagnostic",
		},

		["]d"] = {
			function()
				vim.diagnostic.goto_next({ float = { border = "rounded" } })
			end,
			"Goto next diagnostic",
		},

		["<leader>q"] = {
			function()
				vim.diagnostic.setloclist()
			end,
			"Diagnostic setloclist",
		},

		["<leader>wa"] = {
			function()
				vim.lsp.buf.add_workspace_folder()
			end,
			"Add workspace folder",
		},

		["<leader>wr"] = {
			function()
				vim.lsp.buf.remove_workspace_folder()
			end,
			"Remove workspace folder",
		},

		["<leader>wl"] = {
			function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end,
			"List workspace folders",
		},
	},

	v = {
		["<leader>ca"] = {
			function()
				vim.lsp.buf.code_action()
			end,
			"LSP code action",
		},
	},
}

M.nvimtree = {
	n = {
		["<A-e>"] = { "<cmd>NvimTreeToggle <CR>", "Toggle nvimtree" },
		["<leader>e"] = { "<cmd>NvimTreeFocus <CR>", "Focus nvimtree" },
	},
}

M.avante = {
	n = {
		["<leader>an"] = { "<cmd>AvanteClear<CR> ", "Clear Avante Buffer" },
	},
}

M.telescope = {
	n = {
		-- find
		-- ["<leader>ff"] = { "<cmd> Telescope find_files hidden=true <CR>", "Find files" },
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
		["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
		["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["<leader>fW"] = { "<cmd> Telescope grep_string search= <CR>", "Live fuzzy grep" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
		["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
		["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
		["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
		["<leader>fr"] = { "<cmd> Telescope lsp_references <CR>", "Find references" },
		["<leader>fn"] = { "<cmd> Telescope notify <CR>", "Find notifications" },
		["<leader>ft"] = { "<cmd> Telescope treesitter <CR>", "Find treesitter" },

		-- git
		["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
		["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

		-- theme switcher
		["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
	},
}

M.nvterm = {
	t = {
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"Toggle horizontal term",
		},
	},
	n = {
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle("horizontal")
			end,
			"Toggle horizontal term",
		},
	},
}

M.whichkey = {
	n = {
		["<leader>wK"] = {
			function()
				vim.cmd("WhichKey")
			end,
			"Which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end,
			"Which-key query lookup",
		},
	},
}

M.gitsigns = {
	n = {
		-- Navigation through hunks
		["]c"] = {
			function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return "<Ignore>"
			end,
			"Jump to next hunk",
			opts = { expr = true },
		},

		["[c"] = {
			function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return "<Ignore>"
			end,
			"Jump to prev hunk",
			opts = { expr = true },
		},

		-- Actions
		["<leader>gr"] = {
			function()
				require("gitsigns").reset_hunk()
			end,
			"Reset hunk",
		},

		["<leader>ph"] = {
			function()
				require("gitsigns").preview_hunk()
			end,
			"Preview hunk",
		},

		["<leader>gb"] = {
			function()
				package.loaded.gitsigns.blame_line()
			end,
			"Blame line",
		},

		["<leader>td"] = {
			function()
				require("gitsigns").toggle_deleted()
			end,
			"Toggle deleted",
		},
	},
}

M.git = {
	n = {
		["<leader>gh"] = { "<cmd>G<CR>:only<CR>", "Open Git" },
		["<leader>gl"] = { "<cmd>G log --graph --decorate -n 50<CR>:only<CR>", "Git Log (50 commits)" },
		["<leader>gL"] = { "<cmd>G log --graph --decorate<CR>:only<CR>", "Git Log" },
		["<leader>hc"] = { "/[*] commit \\x\\+<CR>n", "Highlight commits" },
	},
}

M.zen = {
	n = {
		["<leader>z"] = { "<cmd>ZenMode<CR>", "ZenMode" },
	},
	v = {
		["<leader>z"] = { "<cmd>ZenMode<CR>", "ZenMode" },
	},
}

M.auto = {
	n = {
		["<leader>fs"] = { ":SessionSave<CR>", "Save Session" },
	},
}

M.spellcheck = {
	n = {
		["<leader>b"] = { "1z=", "Spell check suggestions" },
	},
}

M.oil = {
	n = {
		["<leader>o"] = { "<cmd>Oil<CR>", "Edit files like vim" },
	},
}

M.marks = {
	n = {
		["<leader>dm"] = { "<cmd>delmarks! | delmarks A-Z<CR>", "Delete all marks in buffer (lowercase and uppercase)" },
		["<leader>dM"] = {
			"<cmd>delmarks! | delmarks A-Z | wshada!<CR>",
			"Delete all marks (including global and uppercase)",
		},
	},
}

M.molten = {
	n = {
		["<leader>m<CR>"] = { "<cmd>noautocmd MoltenEnterOutput<CR>", "Molten Enter Output" },
		["<leader>mD"] = { "<cmd>MoltenDeinit<CR>", "Deinitialize Molten" },
		["<leader>mo"] = { "<cmd>MoltenHideOutput<CR>", "Hide Molten Output" },
		["<leader>mks"] = { "<cmd>MoltenSave<CR>", "Molten Save" },
		["<leader>mkl"] = { "<cmd>MoltenLoad<CR>", "Molten Load" },
		["<leader>r"] = { "<cmd>MoltenEvaluateLine<CR>", "Evaluate line" },
		["<leader>rr"] = { "<cmd>MoltenReevaluateCell<CR>", "Re-evaluate cell" },
		["]b"] = { "<cmd>MoltenNext<CR>", "Next molten block" },
		["[b"] = { "<cmd>MoltenPrev<CR>", "Previous molten block" },
	},
	v = {
		["<leader>m<CR>"] = { "<cmd>noautocmd MoltenEnterOutput<CR>", "Molten Enter Output" },
		["<leader>r"] = { ":<C-u>MoltenEvaluateVisual<CR><ESC>", "Evaluate visual selection" },
		["<leader>mo"] = { "<cmd>MoltenHideOutput<CR>", "Hide Molten Output" },
		["<leader>rr"] = { "<cmd>MoltenReevaluateCell<CR><ESC>", "Re-evaluate cell" },
		["]b"] = { "<cmd>MoltenNext<CR>", "Next molten block" },
		["[b"] = { "<cmd>MoltenPrev<CR>", "Previous molten block" },
	},
}

M.noice = {
	n = {
		["<M-p>"] = { "<cmd>NoiceDismiss<CR>", "Dismiss message" },
	},
}

M.window = {
	n = {
		["<leader>mm"] = {
			function()
				require("codewindow").toggle_minimap()
			end,
			"Toggle minimap",
		},
		["<leader>mf"] = {
			function()
				local codewindow = require("codewindow")
				codewindow.toggle_focus()
				IS_FOCUS = not IS_FOCUS
				if IS_FOCUS then
					vim.o.scrolloff = 999
				else
					vim.o.scrolloff = 8
				end
			end,
			"Toggle focus and center cursor",
		},
	},
}

M.tab = {
	n = {
		["<Tab>"] = { "<Cmd>BufferNext<CR>", "Jump to next tab" },
		["<S-Tab>"] = { "<Cmd>BufferPrevious<CR>", "Jump to previous tab" },
		["<leader>x"] = { "<Cmd>BufferClose<CR>", "Close Buffer" },
		["<leader>X"] = { "<Cmd>BufferCloseAllButCurrent<CR>", "Close all but current Buffer" },
		["<leader>1"] = { "<Cmd>BufferGoto 1<CR>", "Jump to tab 1" },
		["<leader>2"] = { "<Cmd>BufferGoto 2<CR>", "Jump to tab 2" },
		["<leader>3"] = { "<Cmd>BufferGoto 3<CR>", "Jump to tab 3" },
		["<leader>4"] = { "<Cmd>BufferGoto 4<CR>", "Jump to tab 4" },
		["<leader>5"] = { "<Cmd>BufferGoto 5<CR>", "Jump to tab 5" },
		["<leader>6"] = { "<Cmd>BufferGoto 6<CR>", "Jump to tab 6" },
		["<leader>7"] = { "<Cmd>BufferGoto 7<CR>", "Jump to tab 7" },
		["<leader>8"] = { "<Cmd>BufferGoto 8<CR>", "Jump to tab 8" },
		["<leader>9"] = { "<Cmd>BufferGoto 9<CR>", "Jump to tab 9" },
		["<leader>="] = { "<cmd>wincmd =<CR>", "Equalize windows" },
		["<leader>H"] = { "<Cmd>BufferMovePrevious<CR>", "Equalize windows" },
		["<leader>L"] = { "<Cmd>BufferMoveNext<CR>", "Jump to tab 9" },
	},
}

M.undo = {
	n = {
		["<leader>u"] = { "<cmd>UndotreeToggle<cr>", "Toggle Undotree" },
	},
}

-- Helper function to apply formatting
function apply_formatting(start_marker, end_marker, description)
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")
	local start_col = vim.fn.col("v")
	local end_col = vim.fn.col(".")

	-- Ensure start is before end
	if start_line > end_line or (start_line == end_line and start_col > end_col) then
		start_line, end_line = end_line, start_line
		start_col, end_col = end_col, start_col
	end

	-- Get the line content
	local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]

	-- Find word boundaries
	local word_start = start_col
	local word_end = end_col

	while word_start > 1 and line:sub(word_start - 1, word_start - 1):match("%w") do
		word_start = word_start - 1
	end
	while word_end <= #line and line:sub(word_end, word_end):match("%w") do
		word_end = word_end + 1
	end

	-- Apply formatting to the entire word
	local new_line = line:sub(1, word_start - 1)
		.. start_marker
		.. line:sub(word_start, word_end - 1)
		.. end_marker
		.. line:sub(word_end)

	-- Set the modified line
	vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false, { new_line })
end

function apply_formatting_line(start_marker, end_marker, description)
	local start_line = vim.fn.line("v")
	local end_line = vim.fn.line(".")

	-- Ensure start is before end
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	-- Get the line content
	local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]

	-- Apply formatting to the entire line
	local new_line = start_marker .. line .. end_marker

	-- Set the modified line
	vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false, { new_line })
end

M.markdown = {
	n = {
		["<leader>mn"] = {
			function()
				local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				for i, line in ipairs(lines) do
					lines[i] = i .. ". " .. line:gsub("^%d+%.", ""):gsub("^%s*", "")
				end
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
			end,
			"Enumerate selected lines",
		},
		["<leader>mc"] = {
			function()
				local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				for i, line in ipairs(lines) do
					lines[i] = "- [ ] " .. line:gsub("^%- %[.?%] ", ""):gsub("^%- ", ""):gsub("^%s*", "")
				end
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
			end,
			"Add markdown checklist to selected lines",
		},
		["<leader>ml"] = {
			function()
				local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				for i, line in ipairs(lines) do
					lines[i] = "- " .. line:gsub("^%- ", ""):gsub("^%s*", "")
				end
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
			end,
			"Add bullet points to selected lines",
		},
		["<leader>mb"] = {
			function()
				apply_formatting("**", "**", "Make selected word bold")
			end,
			"Make selected word bold",
		},
		["<leader>mi"] = {
			function()
				apply_formatting("*", "*", "Make selected word italic")
			end,
			"Make selected word italic",
		},
		["<leader>ms"] = {
			function()
				apply_formatting_line("~~", "~~", "Add strikethrough to selected word")
			end,
			"Add strikethrough to selected word",
		},
		["<leader>mB"] = {
			function()
				apply_formatting_line("**", "**", "Make selected word bold")
			end,
			"Make selected word bold",
		},
		["<leader>mI"] = {
			function()
				apply_formatting_line("*", "*", "Make selected word italic")
			end,
			"Make selected word italic",
		},
		["<leader>mS"] = {
			function()
				apply_formatting_line("~~", "~~", "Add strikethrough to selected word")
			end,
			"Add strikethrough to selected word",
		},
	},
	v = {
		["<leader>mn"] = {
			function()
				local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				for i, line in ipairs(lines) do
					lines[i] = i .. ". " .. line:gsub("^%d+%.", ""):gsub("^%s*", "")
				end
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
			end,
			"Enumerate selected lines",
		},
		["<leader>mc"] = {
			function()
				local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				for i, line in ipairs(lines) do
					lines[i] = "- [ ] " .. line:gsub("^%- %[.?%] ", ""):gsub("^%- ", ""):gsub("^%s*", "")
				end
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
			end,
			"Add markdown checklist to selected lines",
		},
		["<leader>ml"] = {
			function()
				local start_line, end_line = vim.fn.line("v"), vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				for i, line in ipairs(lines) do
					lines[i] = "- " .. line:gsub("^%- ", ""):gsub("^%s*", "")
				end
				vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
			end,
			"Add bullet points to selected lines",
		},

		["<leader>mb"] = {
			function()
				apply_formatting("**", "**", "Make selected word bold")
			end,
			"Make selected word bold",
		},
		["<leader>mi"] = {
			function()
				apply_formatting("*", "*", "Make selected word italic")
			end,
			"Make selected word italic",
		},
		["<leader>ms"] = {
			function()
				apply_formatting("~~", "~~", "Add strikethrough to selected word")
			end,
			"Add strikethrough to selected word",
		},
		["<leader>mB"] = {
			function()
				apply_formatting_line("**", "**", "Make selected word bold")
			end,
			"Make selected word bold",
		},
		["<leader>mI"] = {
			function()
				apply_formatting_line("*", "*", "Make selected word italic")
			end,
			"Make selected word italic",
		},
		["<leader>mS"] = {
			function()
				apply_formatting_line("~~", "~~", "Add strikethrough to selected word")
			end,
			"Add strikethrough to selected word",
		},
	},
}

-- M.leetcode = {
-- 	n = {
-- 		["<leader>lt"] = { "<cmd>Leet test<CR>", "Run test cases" },
-- 		["<leader>lr"] = { "<cmd>Leet submit<CR>", "Submit" },
-- 		["<leader>ld"] = { "<cmd>Leet desc<CR>", "Toggle description" },
-- 		["<leader>lc"] = { "<cmd>Leet console<CR>", "Toggle console" },
-- 	},
-- }

-- Function to load mappings
local function load_mappings(mappings)
	for mode, mode_mappings in pairs(mappings) do
		for lhs, mapping_info in pairs(mode_mappings) do
			local rhs = mapping_info[1]
			local opts = vim.tbl_extend("force", { desc = mapping_info[2] }, mapping_info.opts or {})
			vim.keymap.set(mode, lhs, rhs, opts)
		end
	end
end

-- Load all mapping tables
for name, mappings in pairs(M) do
	if type(mappings) == "table" then
		load_mappings(mappings)
	end
end

return M
