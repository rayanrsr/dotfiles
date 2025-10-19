<div align="center">
    <h1>Neovim</h1>
</div>



# Why NeoVim ?
- Extensibility and Plugins: Offers a powerful plugin architecture, making it highly customizable and extensible. Users can enhance and tailor their editing environment to suit their specific needs.
- Modern Codebase and Development: Neovim is built with a focus on maintainability and extensibility. It inherits the strengths of Vim but aims to improve upon them with a more modern codebase, making it easier for developers to contribute and address issues.
- Built-in Terminal Emulation: Neovim includes a built-in terminal emulator, allowing users to run shell commands and interact with the system directly from the editor. This feature streamlines workflows and reduces the need to switch between the text editor and an external terminal.
- Async Support: Asynchronous plugin execution is a key feature of Neovim, enabling background tasks without freezing the editor. This improves performance and responsiveness, particularly when dealing with resource-intensive operations or external tools.
- Community Support and Active Development: Neovim has an active and growing community of users and developers. Regular updates and new features ensure that the editor stays relevant and up-to-date with modern coding practices.

# Getting Started :
Welcome to the NeoVim configuration guide. This document provides a comprehensive overview of setting up and using my NeoVim configuration, including keybindings, plugins, and additional tools like tmux.
Initial Setup

To get started with this NeoVim configuration, clone the repository into your NeoVim configuration directory:


### Ensure all LSPs are setup :
:MasonInstallAll

### Setup Copilot :
Copilot is already setup in the editor you just have to run the first time : 
```
:Copilot setup
```
and
```
:Copilot enable
```

### Debug LSP :
Launch the command :
```
:lua print(vim.inspect(vim.lsp.get_active_clients()))
:LspInfo
```
### Conda envionements :
They're managed through https://github.com/kmontocam/nvim-conda
Commands

-    ```:CondaActivate``` - lists conda environments in menu and activates selected
-    ```:CondaActivate <env_name>``` - activates the given conda environment
-    ```:CondaDeactivate``` - deactivates the active conda environment


### Neovim Keybinds :
Reference  for Tutorial : https://ofirgall.github.io/learn-nvim/chapters/00-why-should-i-learn.html
| Keybinding  | Description |
| ------------- | ------------- |
| :!command (for example run binary or do python) | Execute shell commands |

Explore Project :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl p | Telescope lookup a file |
| Space pf | Telescope lookup a GIT file |
| Space pv | Go back to file explorer |
| Space + ps | Content File search |
| Ctrl + f | Tmux Jump Between projects |
| d | Delete |
| a (in file explorer) | Create new File |
| A (in file explorer) | Create new Directory |
| r (in file explorer) | Rename  |
| q (in file explorer) | Close  |
| m (in file explorer) | Move  |


In File
| Keybinding  | Description |
| ------------- | ------------- |
| y y p | Duplicate line |
| u | Undo |
| Ctrl r | Redo |
| x | Delete character under cursor |
| r | Replace character under cursor |
| _ | JUMP BEGINNING LINE |
| $ | JUMP END LINE |
| p | New LINE |
| r | Replace character under cursor |
| o | New LINE after |
| O | New LINE before |
| gg | JUMP BEGINNING FILE |
| G | JUMP END FILE |
| A | Move in insert mode to beginning of the line |
| a | Move in insert mode AFTER the cursor |
| a | Move in insert mode AFTER the cursor |
| d | Delete and put in buffer |
| dd | Delete a line |
| f + Character | Jump-on Forward where the caracter appears in the line |
| t + Character | Jump-to Forward where the caracter appears in the line |
| g d | Jump to DEFINITION |
| Ctrl O | Jump BACK FROM DEFINITION |
| Ctrl d | Half page JUMP FORWARD | 
| Ctrl u | Half page JUMP BACKWARD |
| Space u | Open Undo tree |
| Space gs | Open Fugitive Git manipulation |
| {/} | Jump between Paragraphs | 
| vi" | Select everything inside " | 
| vi( | Select everything inside next ( |
| ci( | Change everything inside next ( |
| va{ | Select everything inside actual { (when you put 'a' it means all/actual so it selects even if you are in the middle of the { |
| Visual mode : g c | COMMENT |
| ]m | Jump to next Function/Method |
| Space + r | Run main python file or main bash file at the root | 
| Space + t | Run tests with pytest |
| gr | See references of a blob with LSP through telescope |
| gd | Go to definition of a blob with LSP |
| s <character> | Use leap to search for a character |
| r e | refactor extract with LSP |
| r f | refactor extract to file |
| r v | refactor extract variable |
| r b | refactor extract block |
| r b f | refactor extract block file |
| r n | refactor rename |
| Ctrl ^ |  typically toggles between the current buffer and the previously edited buffer. This allows you to quickly switch back and forth between two buffers. It's particularly useful when you need to refer to or copy/paste content between two different files without losing your current editing context. |
| 5 j | in [] for example jump to beginning |
| 5 k | in [] for example jump to ending |

TERMINAL :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl t | Open/Close Terminal |
| Ctrl r | Fzf through history | 


LSP :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl y | Accept an LSP suggestion |
| Ctrl n | Next LSP suggestion |
| Ctrl p | Previous LSP suggestion |

MULTI PAGE :
Every multi page command start usually with Ctrl w
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl w h/j/k/l | Move in directions between the windows |
| Ctrl w s | Create Horizontal split |
| Ctrl w v | Create Vertical split |
| Ctrl w o | Close all splits except current |
| Ctrl w c | Close current split |

HARPOON :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl a | APPEND file to harpoon |
| Ctrl x | REMOVE file to harpoon |
| Ctrl e | TOGGLE MENU |
| Space 1 | Nav 1 |
| Space 2 | Nav 2 |
| Space 3 | Nav 3 |
| Space 4 | Nav 4 |

TMUX :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl b h/j/k/l | Move between Panes |
| Shift Alt h/l | Move between Windows |

GIT :
| Keybinding  | Description |
| ------------- | ------------- |
| Space g g | Activate LazyGit |
| Space g a | Git add all project |
| Space g A | Git add current file |
| Space g c | Git Commit |
| Space g p | Git Push |
| Space g P | Git Pull |
| Space g c o | Git Conflict Accept Ours |
| Space g c t | Git Conflict Accept Theirs |
| Space g c n | Git Conflict Next Conflict |
| Space g c p | Git Conflict Previous Conflict |


Indentation :
Here's a step-by-step example:

- Move to the first line you want to indent.
- Press v to start visual mode.
- Select the lines with the arrow keys.
- Press > to indent right or < to indent left.
- Press Esc to exit visual mode.

| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl-b "	| Split pane horizontally |
| Ctrl-b %	| Split pane vertically |
| Ctrl-b arrow key	| Navigate between panes (use arrow keys for direction) |
| Ctrl-b c	| Create a new window |
| Ctrl-b w	| List windows to select |
| Ctrl-b n	| Move to the next window |
| Ctrl-b p	| Move to the previous window |
| Ctrl-b &	| Kill the current window |
| Ctrl-b x	| Kill the current pane |
| Ctrl-b [	| Enter scroll mode (navigate using arrow keys, exit with q) |
| Ctrl-b ]	| Paste from the tmux buffer |
| Ctrl-b z	| Toggle pane zoom |
| Ctrl-b d	| Detach from the current session |
| Ctrl-b t	| Show a large clock in the current pane |
| Ctrl-b ,	| Rename the current window |
| Ctrl-b $	| Rename the current session |
| Ctrl-b o	| Rotate panes |
| Ctrl-b ;	| Toggle between the current and previous pane |
| Ctrl-b q	| Show pane numbers (press number to switch to that pane) |
| Ctrl-b {	| Move the current pane left |
| Ctrl-b }	| Move the current pane right |
| Ctrl-b L	| Move to the previously selected pane |
| Ctrl-b M	| Toggle mouse mode on/off |
| Ctrl-b :	| Enter command mode |
| { | Jump between Paragraphs before |
| } | Jump between Paragraphs after |


Interaction with selectors :
| Keybinding  | Description |
| ------------- | ------------- |
| v i "	| Select inside "" |
| c i "	| Change/remove inside "" |


# NeoVim Plugins Overview

This section provides an overview of the plugins used in this NeoVim configuration, along with their purpose and functionality.



## Core Functionality


- **[lazy.nvim](https://github.com/folke/lazy.nvim)**: A plugin to facilitate lazy loading of other plugins, improving startup time.


## Navigation & File Management

- **[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: A highly extendable fuzzy finder over lists.
- **[nvim-tree/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)**: A file explorer tree for navigating and managing your filesystem.
- **[theprimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)**: Bookmark manager for quick navigation between frequently used files.
- **[numToStr/Navigator.nvim](https://github.com/numToStr/Navigator.nvim)**: Seamlessly navigate between splits and windows.

## User Interface Enhancements

- **[rose-pine/neovim](https://github.com/rose-pine/neovim)**: The Rose Pine theme for a comfortable and aesthetic coding environment.
- **[akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)**: An elegant and powerful buffer line (tab line) plugin.
- **[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: A fast and easy-to-configure status line plugin.
- **[folke/which-key.nvim](https://github.com/folke/which-key.nvim)**: Displays a popup with possible keybindings following your currently entered incomplete command.
- **[gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim)**: Enhances command-line completion, search, and more.
- **[folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)**: A clean, dark Neovim theme that celebrates the lights of downtown Tokyo at night.

## Syntax & Language Support

- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Treesitter configurations and abstraction layer for Neovim.
- **[nvim-treesitter/nvim-treesitter-context](https://github.com/romgrk/nvim-treesitter-context)**: Shows the context of the current function/class you're in.


## Development & Debugging

- **[mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)**: A Debug Adapter Protocol client implementation for stepping through code and breakpoints.
- **[rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)**: A UI for nvim-dap.
- **[mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)**: Python specific configurations for nvim-dap.
- **[simrat39/rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)**: Extra functionality for Rust programming.
- **[mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)**: An asynchronous linter plugin.

## Language Server Protocol (LSP) & Autocompletion

- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: Quickstart configurations for the Nvim LSP client.

- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)**: Portable package manager for Neovim that installs language servers, linters, and formatters.
- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Autocompletion plugin that integrates with various sources.
- **[hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)**: Nvim-cmp source for neovim's built-in language server client.
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)**: A snippet engine for Neovim written in Lua.
- **[hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)**: Path autocompletion for nvim-cmp.

## Utility & Miscellaneous

- **[terrortylor/nvim-comment](https://github.com/terrortylor/nvim-comment)**: Easily comment out lines or sections of code.
- **[mbbill/undotree](https://github.com/mbbill/undotree)**: Visualize the undo tree to navigate through changes.
- **[github/copilot.vim](https://github.com/github/copilot.vim)**: GitHub Copilot plugin for autocompleting code.
- **[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)**: A Git wrapper so powerful, it should be illegal.
- **[averms/black-nvim](https://github.com/averms/black-nvim)**: Integration with the Black Python code formatter.
- **[rmagatti/auto-session](https://github.com/rmagatti/auto-session)**: A small automated session manager for Neovim.
- **[kmontocam/nvim-conda](https://github.com/kmontocam/nvim-conda)**: Manage Conda environments within Neovim.
- **[nvimdev/guard.nvim](#)**: .
