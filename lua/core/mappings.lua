-- mappings.lua

local M = {}

-- Helper function to set keymaps
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- General mappings
M.general = {
    n = {
        -- Basic operations
        ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
        ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
        ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
        ["<leader>fm"] = {
            function() vim.lsp.buf.format { async = true } end,
            "LSP formatting"
        },
        
        -- Window navigation
        ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
        ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
        ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
        ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },
        
        -- Custom Alt mappings
        ["<M-h>"] = { "^", "Move to beginning of previous word" },
        ["<M-l>"] = { "$", "Move to end of current word" },
        ["<M-j>"] = { "}", "Move to next paragraph" },
        ["<M-k>"] = { "{", "Move to previous paragraph" },
        ["<M-n>"] = { "%", "Move to matching bracket" },
        
        -- Line operations
        ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
        ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
        ["P"] = { ":pu<CR>]==", "Paste below" },
        
        
        -- Additional mappings from paste-2.txt
        ["<leader>s"] = { [[:%s/\v(<C-r><C-w>)//gI<Left><Left><Left>]], "Find and replace" },
        ["n"] = { "nzzzv", "Next search result center screen" },
        ["N"] = { "Nzzzv", "Previous search result center screen" },
        ["<leader>d'"] = { ":delmarks a-zA-Z<CR>", "Delete all marks" },
        ["<C-w>a"] = { ":qall<CR>", "Quit Nvim" },
        ["<C-n>"] = { ":qall<CR>", "Quit Nvim" },
        ["<leader>pd"] = { ":echo expand('%:p:h')<CR>", "Print file path" },
        ["<leader>ll"] = { ":LspStart<CR>", "Start LSP service" },
        ["<leader>lp"] = { ":LspStop<CR>", "Stop LSP service" },
        ["<A-d>"] = { "<C-e><C-e>", "Scroll window down" },
        ["<A-u>"] = { "<C-y><C-y>", "Scroll window up" },
    },
    v = {
        -- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        -- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["<"] = { "<gv", "Unindent line" },
        [">"] = { ">gv", "Indent line" },
        ["<Tab>"] = { ">gv", "Indent line" },
        ["<S-Tab>"] = { "<gv", "Unindent line" },
        ["<M-h>"] = { "^", "Move to beginning of previous word" },
        ["<M-l>"] = { "$", "Move to end of current word" },
        ["<M-j>"] = { "}", "Move to next paragraph" },
        ["<M-k>"] = { "{", "Move to previous paragraph" },
        ["<M-n>"] = { "%", "Move to matching bracket" },
        ["J"] = { ":m '>+1<CR>gv=gv", "Move text down" },
        ["K"] = { ":m '<-2<CR>gv=gv", "Move text up" },
        ["<A-d>"] = { "<C-e><C-e>", "Scroll window down" },
        ["<A-u>"] = { "<C-y><C-y>", "Scroll window up" },
    },
    x = {
        -- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        -- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Don't copy replaced text", opts = { silent = true } },
    },
    i = {
        ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
        ["<C-e>"] = { "<End>", "End of line" },
        ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "Window left" },
        ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "Window right" },
        ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "Window down" },
        ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "Window up" },
        ["<S-Tab>"] = { "<C-d>", "Inverse tab" },
    },
    t = {
        ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    },
}

-- Plugin-specific mappings
M.tabufline = {
    n = {
        ["<tab>"] = {
            function() require("nvchad.tabufline").tabuflineNext() end,
            "Goto next buffer"
        },
        ["<S-tab>"] = {
            function() require("nvchad.tabufline").tabuflinePrev() end,
            "Goto prev buffer"
        },
        ["<leader>x"] = {
            function() require("nvchad.tabufline").close_buffer() end,
            "Close buffer"
        },
        ["<C-t>"] = { ":tabedit<CR>", "Open new tab" },
        ["<A-t>"] = { ":tabclose<CR>", "Close tab" },
        ["<leader>="] = { ":wincmd =<CR>", "Equalize windows" },
    },
}

M.comment = {
    n = {
        ["<leader>/"] = {
            function() require("Comment.api").toggle.linewise.current() end,
            "Toggle comment"
        },
    },
    v = {
        ["<leader>/"] = {
            "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
            "Toggle comment"
        },
    },
}

M.lspconfig = {
    -- (LSP mappings remain the same, omitted for brevity)
}

M.nvimtree = {
    n = {
        ["<A-e>"] = { ":NvimTreeToggle <CR>", "Toggle nvimtree" },
        ["<leader>e"] = { ":NvimTreeFocus <CR>", "Focus nvimtree" },
    },
}

M.telescope = {
    -- (Telescope mappings remain the same, omitted for brevity)
}

M.nvterm = {
    t = {
        ["<A-i>"] = {
            function() require("nvterm.terminal").toggle "horizontal" end,
            "Toggle horizontal term"
        },
    },
    n = {
        ["<A-i>"] = {
            function() require("nvterm.terminal").toggle "horizontal" end,
            "Toggle horizontal term"
        },
    },
}

M.whichkey = {
    -- (Whichkey mappings remain the same, omitted for brevity)
}

M.blankline = {
    -- (Blankline mappings remain the same, omitted for brevity)
}

M.gitsigns = {
    -- (Gitsigns mappings remain the same, omitted for brevity)
}

M.git = {
    n = {
        ["<leader>gh"] = { ":G<CR>:only<CR>", "Open Git" },
        ["<leader>gl"] = { ":G log --graph --decorate<CR>:only<CR>", "Git Log" },
        ["<leader>hc"] = { "/[*] commit \\x\\+<CR>n", "Highlight commits" },
    },
}

M.auto = {
    n = {
        ["<leader>fs"] = { ":SessionSave<CR>", "Save Session" },
        ["<leader>fR"] = { ":SessionRestore<CR>", "Restore Session" },
    },
}

M.window = {
    n = {
        ["<leader>mm"] = {
            function() require("codewindow").toggle_minimap() end,
            "Toggle minimap"
        },
        ["<leader>mf"] = {
            function()
                local codewindow = require "codewindow"
                codewindow.toggle_focus()
                IS_FOCUS = not IS_FOCUS
                if IS_FOCUS then
                    vim.o.scrolloff = 999
                else
                    vim.o.scrolloff = 8
                end
            end,
            "Toggle focus and center cursor"
        },
    },
}

M.leetcode = {
    n = {
        ["<leader>lt"] = { ":Leet test<CR>", "Run test cases" },
        ["<leader>lr"] = { ":Leet submit<CR>", "Submit" },
        ["<leader>ld"] = { ":Leet desc<CR>", "Toggle description" },
        ["<leader>lc"] = { ":Leet console<CR>", "Toggle console" },
    },
}

M.GPT = {
    n = {
        ["<leader>gr"] = { ":ChatGPTRun ", "ChatGPT Run" },
        ["<leader>gg"] = { ":ChatGPT", "ChatGPT" },
    },
    v = {
        ["<leader>ge"] = { ":ChatGPTRun explain_code<CR>", "ChatGPT Explain Code" },
        ["<leader>go"] = { ":ChatGPTRun optimize_code<CR>", "ChatGPT Optimize Code" },
        ["<leader>gt"] = { ":ChatGPTRun add_tests<CR>", "ChatGPT Add Test" },
        ["<leader>gc"] = { ":ChatGPTRun complete_code<CR>", "ChatGPT Complete Code" },
        ["<leader>gb"] = { ":ChatGPTRun fix_bugs<CR>", "ChatGPT Fix Bugs" },
    },
}

M.dap = {
    n = {
        ["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Add breakpoint at line" },
        ["<leader>dc"] = { "<cmd> DapContinue <CR>", "Continue to next breakpoint" },
        ["<leader>dj"] = { "<cmd> DapStepInto <CR>", "Step into function/Next" },
        ["<leader>dk"] = { "<cmd> DapStepOut <CR>", "Step out of function" },
        ["<leader>dJ"] = { "<cmd> DapStepOver <CR>", "Step over function/Next in buffer" },
        ["<leader>dq"] = { "<cmd> DapTerminate <CR>", "Exit" },
        ["<leader>dd"] = {
            function() require("dap").continue() end,
            "Run debugger"
        },
    },
}

-- Apply all mappings
for mode, mode_mappings in pairs(M.general) do
    for lhs, mapping in pairs(mode_mappings) do
        map(mode, lhs, mapping[1], { desc = mapping[2] })
    end
end

return M
