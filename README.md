# dotnvim

Personal Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim). Catppuccin Mocha with transparent background.

## Requirements

- Neovim 0.11+
- Git
- Node.js (for some LSP servers)
- Python 3.10+ (for Jupyter/molten support)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

## Install

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone
git clone https://github.com/lsantos7654/dotnvim.git ~/.config/nvim

# Python dependencies (for Jupyter/image support)
pip install pynvim cairosvg pnglatex kaleido pyperclip jupyter-client

# Launch — plugins install automatically
nvim
```

## Structure

```
lua/
├── core/
│   ├── options.lua          # Editor settings
│   └── mappings.lua         # All keybindings
└── plugins/
    ├── code_assistance/     # LSP, completion, formatting, leetcode
    ├── ui_visual/           # Theme, statusline, treesitter, notifications
    ├── navigation/          # Telescope, nvim-tree, oil
    ├── dev_tools/           # Git, terminal, Jupyter, image support
    └── session/             # Session management
```

## Plugins

**LSP & Completion**: mason.nvim, nvim-lspconfig, nvim-cmp, conform.nvim

**Navigation**: telescope.nvim, nvim-tree, oil.nvim, vim-tmux-navigator

**UI**: catppuccin, lualine.nvim, barbar.nvim, noice.nvim, nvim-notify, indent-blankline, which-key

**Treesitter**: nvim-treesitter, treesitter-textobjects, treesitter-context

**Git**: fugitive, gitsigns.nvim

**Markdown**: mkdnflow.nvim, render-markdown.nvim, nabla.nvim

**Data Science**: molten-nvim (Jupyter), image.nvim, otter.nvim

**Misc**: comment.nvim, zen-mode, todo-comments, undotree, leetcode.nvim

## Language Support

| Language | LSP | Formatter | Linter |
|---|---|---|---|
| Lua | lua_ls | stylua | built-in |
| Python | pyright | ruff / black | ruff / mypy |
| JS/TS | eslint | prettier | eslint |
| C/C++ | clangd | clang-format | built-in |
| HTML/CSS | html-ls | prettier | built-in |
| JSON/YAML | json-ls | prettier / fixjson | built-in |
| Bash | bash-ls | shfmt | shellcheck |
| Bazel | bzl | buildifier | built-in |

## Key Mappings

Leader is `Space`.

### Navigation

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fo` | Recent files |
| `<leader>e` | Focus file explorer |
| `<leader>o` | Oil file editor |
| `<C-h/j/k/l>` | Window/tmux navigation |
| `<Tab>` / `<S-Tab>` | Next/prev buffer |
| `<leader>1-9` | Jump to buffer N |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>fm` | Format |
| `<leader>lf` | Floating diagnostic |
| `[d` / `]d` | Prev/next diagnostic |

### Git

| Key | Action |
|---|---|
| `<leader>gh` | Open fugitive |
| `<leader>gb` | Blame line |
| `<leader>ph` | Preview hunk |
| `<leader>gr` | Reset hunk |
| `]c` / `[c` | Next/prev hunk |

### Jupyter (Molten)

| Key | Action |
|---|---|
| `<leader>r` | Evaluate line |
| `<leader>r` (visual) | Evaluate selection |
| `<leader>rr` | Re-evaluate cell |
| `]b` / `[b` | Next/prev cell |

### Markdown

| Key | Action |
|---|---|
| `<leader>mb` | Bold word |
| `<leader>mi` | Italic word |
| `<leader>ms` | Strikethrough |
| `<leader>mn` | Numbered list |
| `<leader>mc` | Checklist |
| `<leader>ml` | Bullet list |

### LeetCode

| Key | Action |
|---|---|
| `:Leet` | Open dashboard |
| `<leader>lt` | Run tests |
| `<leader>lr` | Submit |
| `<leader>ld` | Toggle description |

### Other

| Key | Action |
|---|---|
| `<leader>/` | Toggle comment |
| `<leader>z` | Zen mode |
| `<leader>u` | Undo tree |
| `<leader>x` | Close buffer |
| `<C-s>` | Save |
| `<C-n>` | Quit |

## License

[MIT](LICENSE)
