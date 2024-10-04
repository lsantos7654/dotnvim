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
  -- Molten (Jupyter Notebooks)
  require("plugins.molten"),

  -- Image support
  require("plugins.image"),

  -- UI enhancements
  require("plugins.noice"),

  -- Luarocks support
  require("plugins.luarocks"),

  -- Treesitter for better syntax highlighting and code understanding
  require("plugins.treesitter"),

  -- File explorer
  require("plugins.nvim-tree"),

  -- Icons for nvim-tree and other plugins
  require("plugins.web-devicons"),

  require("plugins.avante"),

  require("plugins.auto-session"),

  { "nvim-neotest/nvim-nio" },

  require("plugins.nvim-lastplace"),

  { "christoomey/vim-tmux-navigator", lazy = false },

})
