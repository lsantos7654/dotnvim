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
  -- Session management
  require("plugins.nvim-lastplace"), -- Remember last editing position
  require("plugins.auto-session"), -- Automatic session management

  -- IDE-like features
  require("plugins.treesitter"),  -- Better syntax highlighting and code understanding
  require("plugins.nvimtree"),    -- File explorer
  require("plugins.web-devicons"), -- Icons for nvim-tree and other plugins
  require("plugins.telescope"),   -- Fuzzy finder and more
  { "nvim-neotest/nvim-nio" },    -- Asynchronous I/O operations

  -- UI enhancements
  require("plugins.noice"),       -- Replaces UI for cmdline, messages, and popupmenu
  require("plugins.notify"),       -- Replaces UI for cmdline, messages, and popupmenu
  require("plugins.avante"),      -- Custom UI enhancements
  require("plugins.tabs"),


  -- File type specific
  require("plugins.molten"),      -- Jupyter Notebook integration
  require("plugins.image"),       -- Image viewing support

  -- Utility
  require("plugins.luarocks"),    -- LuaRocks package manager integration
  require("plugins.fugitive"), -- Remember last editing position
  require("plugins.comment"),

  -- Navigation
  { "christoomey/vim-tmux-navigator", lazy = false }, -- Seamless navigation between tmux panes and vim splits

  --LSP
  require("plugins.null-ls"),
  require("plugins.mason"),
  require("plugins.lsp"),
  require("plugins.lsp-zero"),

  -- Autocompletion
  require("plugins.cmp"),
})
