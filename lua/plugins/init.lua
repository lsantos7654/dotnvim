-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy and plugins
require("lazy").setup({
    -- Editor Enhancements
    {
        -- Session Management
        require("plugins.nvim-lastplace"), -- Remember last cursor position in files
        require("plugins.auto-session"),   -- Automatic session management for projects

        -- Navigation and Exploration
        require("plugins.nvimtree"),       -- File explorer sidebar
        require("plugins.telescope"),      -- Fuzzy finder for files, buffers, and more
        {
            "christoomey/vim-tmux-navigator",
            lazy = false,
        },                                 -- Seamless navigation between tmux panes and vim splits

        -- Code Understanding and Navigation
        require("plugins.treesitter"),     -- Advanced syntax highlighting and code analysis
        require("plugins.codewindow"),     -- Minimap-style code outline
    },

    -- UI and Visual Enhancements
    {
        require("plugins.web-devicons"),   -- File icons for various plugins
        require("plugins.noice"),          -- Enhance UI for commandline, messages, and popupmenu
        require("plugins.notify"),         -- Fancy notification system
        require("plugins.avante"),         -- Custom UI improvements
        require("plugins.tabs"),           -- Enhanced tab management
        require("plugins.blankline"),      -- Show indentation guides
        require("plugins.whichkey"),       -- Interactive keybinding helper
        require("plugins.status"),         -- Customizable status line
        require("plugins.theme"),          -- Color scheme and theming
    },

    -- Development Tools
    {
        -- Version Control
        require("plugins.fugitive"),       -- Git integration
        require("plugins.gitsigns"),       -- Show git changes in the sign column

        -- Terminal Integration
        require("plugins.nvterm"),         -- Better terminal integration
        { "nvim-neotest/nvim-nio" },       -- Asynchronous I/O library (dependency for some plugins)

        -- Language Support
        require("plugins.luarocks"),       -- LuaRocks package manager integration
        require("plugins.molten"),         -- Jupyter Notebook integration in Neovim
        require("plugins.image"),          -- Image viewing support within Neovim
    },

    -- Coding Assistance
    {
        -- Language Server Protocol (LSP)
        require("plugins.mason"),          -- Manage LSP servers, linters, and formatters
        require("plugins.lsp"),            -- LSP configuration
        require("plugins.lsp-zero"),       -- Simplified LSP setup

        -- Autocompletion
        require("plugins.cmp"),            -- Intelligent code completion

        -- Coding Utilities
        require("plugins.comment"),        -- Easy code commenting
        require("plugins.zen"),            -- Distraction-free coding mode
    },
})
