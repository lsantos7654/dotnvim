vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.tabstop = 4       -- Number of spaces a TAB counts for
vim.opt.shiftwidth = 4    -- Number of spaces to use for auto-indenting
vim.opt.softtabstop = 4   -- Number of spaces that a <Tab> counts for while editing

vim.wo.number = true
vim.wo.relativenumber = true

vim.g.mapleader = " "

-- vim.opt.transparent = true
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })
