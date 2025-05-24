# 🚀 NeoVim Configuration

*A modern, powerful, and beautifully crafted Neovim setup for developers*

[![Neovim](https://img.shields.io/badge/Neovim-0.11+-brightgreen.svg?style=for-the-badge&logo=neovim)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Made%20with-Lua-blueviolet.svg?style=for-the-badge&logo=lua)](https://lua.org)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

<img src="https://user-images.githubusercontent.com/your-screenshot.png" alt="Neovim Screenshot" width="800"/>

*Productivity meets aesthetics in this carefully curated development environment*

</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎯 **Development Experience**
- 🔥 **Native LSP** with zero-config language servers
- 🚀 **Smart Autocompletion** with context-aware suggestions
- 🎨 **Modern Formatting** using conform.nvim
- 🔍 **Fuzzy Finding** with Telescope integration
- 📝 **Snippet Support** with LuaSnip
- 🐛 **Integrated Debugging** ready to go

</td>
<td width="50%">

### 🎨 **Visual & UI**
- 🌙 **Catppuccin Theme** with transparent background
- 📊 **Beautiful Status Line** with Feline
- 🗂️ **Smart Tabs** with Barbar
- 🌳 **File Explorer** with NvimTree + Oil
- 🔔 **Modern Notifications** with Noice + Notify
- ✨ **Smooth Animations** throughout

</td>
</tr>
</table>

---

## 🛠️ Language Support

<div align="center">

| Language | LSP | Formatter | Linter | Debugger |
|----------|-----|-----------|--------|----------|
| **Python** | Pyright | Ruff/Black | Ruff/MyPy | DebugPy |
| **Lua** | lua_ls | StyLua | Built-in | - |
| **JavaScript/TypeScript** | ESLint | Prettier | ESLint | - |
| **C/C++** | Clangd | clang-format | Built-in | CodeLLDB |
| **HTML/CSS** | HTML-LS | Prettier | Built-in | - |
| **JSON/YAML** | JSON-LS | Prettier | Built-in | - |
| **Bash/Shell** | Bash-LS | shfmt | ShellCheck | - |
| **Bazel** | bzl | Buildifier | Built-in | - |

</div>

---

## 🚀 Quick Start

### Prerequisites

- **Neovim 0.11+** (required for modern LSP features)
- **Git** (for plugin management)
- **Node.js** (for some language servers)
- **Python 3.8+** (for Python development)

### Installation

```bash
# 1. Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# 2. Clone this configuration
git clone https://github.com/lsantos7654/dotnvim.git ~/.config/nvim

# 3. Install dependencies (Ubuntu)
# If on mac install this instead
# brew install lua luarocks
sudo apt install -y liblua5.1-0-dev libmagickwand-dev luarocks
pip install pynvim cairosvg pnglatex kaleido pyperclip jupyter-client


# 4. Launch Neovim
nvim
```

The configuration will automatically:
- Install Lazy.nvim plugin manager
- Download and install all plugins
- Set up language servers via Mason
- Configure everything for immediate use

---

## 📁 Project Structure

```
~/.config/nvim/
├── 📁 lua/
│   ├── 📁 core/
│   │   ├── 🔧 options.lua      # Core Neovim settings
│   │   └── ⌨️  mappings.lua     # Keybindings & shortcuts
│   └── 📁 plugins/
│       ├── 📁 code_assistance/
│       │   ├── 🔌 lsp.lua      # Language Server setup
│       │   ├── 🎯 cmp.lua      # Autocompletion
│       │   ├── ✨ conform.lua  # Code formatting
│       │   └── 🤖 avante.lua   # AI assistance
│       ├── 📁 ui_visual/
│       │   ├── 🎨 theme.lua    # Color scheme
│       │   ├── 📊 status.lua   # Status line
│       │   └── 🗂️  tabs.lua     # Tab management
│       ├── 📁 navigation/
│       │   ├── 🔍 telescope.lua # Fuzzy finder
│       │   └── 🌳 nvimtree.lua  # File explorer
│       └── 📁 dev_tools/
│           ├── 🔀 gitsigns.lua # Git integration
│           └── 📝 molten.lua   # Jupyter support
└── 🚀 init.lua                 # Entry point
```

---

## ⌨️ Key Mappings

<details>
<summary><b>🔥 Essential Shortcuts (Click to expand)</b></summary>

### Navigation & Files
```lua
<leader>ff  -- Find files
<leader>fw  -- Live grep search
<leader>fb  -- Find buffers
<leader>e   -- Toggle file explorer
<leader>o   -- Oil file editor
```

### LSP & Code
```lua
gd          -- Go to definition
gr          -- Find references
K           -- Hover documentation
<leader>ca  -- Code actions
<leader>fm  -- Format code
[d / ]d     -- Navigate diagnostics
```

### Git Integration
```lua
<leader>gh  -- Open Git status
<leader>gb  -- Git blame
]c / [c     -- Next/prev git hunk
<leader>ph  -- Preview hunk
```

### Productivity
```lua
<leader>/   -- Toggle comment
<leader>z   -- Zen mode
<leader>u   -- Undo tree
<C-h/j/k/l> -- Window navigation
<Tab>       -- Next buffer
<S-Tab>     -- Previous buffer
```

</details>

---

## 🎨 Customization

### Themes
The configuration uses **Catppuccin** with transparent background. To change themes:

```lua
-- In lua/plugins/ui_visual/theme.lua
vim.cmd.colorscheme("your-theme-name")
```

### Adding Language Servers
```lua
-- In lua/plugins/code_assistance/mason.lua
ensure_installed = {
    "your-language-server",  -- Add here
    -- ... existing servers
}
```

### Custom Keymaps
```lua
-- In lua/core/mappings.lua
M.your_plugin = {
    n = {
        ["<leader>xx"] = { "<cmd>YourCommand<CR>", "Description" },
    }
}
```

---

## 🧪 Special Features

### 📊 **Data Science Ready**
- **Molten**: Jupyter notebook integration
- **Image Support**: View plots and images inline
- **Quarto**: R/Python notebook support

### 🤖 **AI-Powered Development**
- **Avante**: AI code assistance
- **Copilot**: GitHub Copilot integration
- **Smart Completions**: Context-aware suggestions

### 📝 **Markdown Excellence**
- **Live Preview**: Real-time markdown rendering
- **Math Support**: LaTeX equation rendering
- **Mermaid Diagrams**: Flow chart support

---

## 🔧 Troubleshooting

<details>
<summary><b>Common Issues & Solutions</b></summary>

### LSP Not Working
```bash
# Check LSP status
:LspInfo

# Install missing servers
:Mason
:MasonInstallAll
```

### Plugins Not Loading
```bash
# Check plugin status
:Lazy

# Update plugins
:Lazy update
```

### Performance Issues
```bash
# Check startup time
nvim --startuptime startup.log

# Profile plugins
:Lazy profile
```

</details>

---

## 🤝 Contributing

Contributions are welcome! Please feel free to:

1. 🐛 **Report bugs** via Issues
2. 💡 **Suggest features** or improvements
3. 🔀 **Submit pull requests** with enhancements
4. 📖 **Improve documentation**

---

## 📜 License

This configuration is open source and available under the [MIT License](LICENSE).

---

<div align="center">

### 🌟 **Star this repo if it helped you!** 🌟

*Happy coding with Neovim!* 🚀

---

**Built with ❤️ by [Santos](https://github.com/lsantos7654)**

*"Code is poetry written in logic"*

</div>
```

This landing page includes:

## ✨ **Modern Features:**
- **Responsive design** with tables and collapsible sections
- **Beautiful badges** and status indicators  
- **Organized sections** with clear structure
- **Visual hierarchy** using emojis and formatting
- **Interactive elements** like expandable sections
- **Professional layout** with centered content

## 📋 **Comprehensive Content:**
- **Feature overview** with your actual plugins
- **Language support matrix** showing capabilities
- **Installation instructions** for macOS
- **Project structure** visualization
- **Key mappings** reference
- **Customization guides**
- **Troubleshooting section**
- **Contributing guidelines**

## 🎯 **Highlights Your Setup:**
- Native LSP configuration (modern approach)
- Conform.nvim for formatting
- Mason for tool management
- Comprehensive plugin ecosystem
- Developer-friendly features

Just replace `https://github.com/lsantos7654/dotnvim.git` with your actual repo URL and add a screenshot if you have one. This will make your configuration look professional and attract other developers! 🚀
