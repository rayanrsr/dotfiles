<div align="center">
 <h1>RayTerm</h1>
  <img src="https://github.com/rayanramoul/RayTerm/blob/master/screenshot.png?raw=true" alt="RayTerm">
  </img>

</div>


# Getting Started :
Welcome to the NeoVim configuration guide. This document provides a comprehensive overview of setting up and using my NeoVim configuration, including keybindings, plugins, and additional tools like tmux.
Initial Setup

To get started with this NeoVim configuration, clone the repository into your NeoVim configuration directory:

# Initial Setup
```bash
git clone https://github.com/rayanramoul/nvim-configs ~/.config/nvim
```

and then run all the .sh scripts in that directory!

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
| vi( | Select everything inside ( |
| Visual mode : g c | COMMENT |

TERMINAL :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl t | Open/Close Terminal |


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

DAP DEBUGGING :
| Keybinding  | Description |
| ------------- | ------------- |
| Space d b | TOGGLE BREAKPOINT |
| Space d l | RUN LAST |
| Space d c | CONTINUE |
| Space d u i | DAP UI TOGGLE |
| Space 5 | RUN CURRENT FILE |

TMUX :
| Keybinding  | Description |
| ------------- | ------------- |
| Ctrl b h/j/k/l | Move between Panes |
| Shift Alt h/l | Move between Windows |

GIT :
| Keybinding  | Description |
| ------------- | ------------- |
| Space g g | Activate LazyGit |


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

# TODO
- Add bpytop
- Add lsd insted of ls
- Add fast neofetch at the start of zsh call
- Add ANSIBLE ssh restoration
- Add bat instead of cat

# NeoVim Plugin Overview

This section provides an overview of the plugins used in this NeoVim configuration, along with their purpose and functionality.

### Core Functionality
- **[lazy.nvim](https://github.com/folke/lazy.nvim)**: A plugin to facilitate lazy loading of other plugins, improving startup time.

### Navigation & File Management

- **[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**: A highly extendable fuzzy finder over lists.
- **[nvim-tree/nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua)**: A file explorer tree for navigating and managing your filesystem.
- **[theprimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)**: Bookmark manager for quick navigation between frequently used files.
- **[numToStr/Navigator.nvim](https://github.com/numToStr/Navigator.nvim)**: Seamlessly navigate between splits and windows.

### User Interface Enhancements

- **[rose-pine/neovim](https://github.com/rose-pine/neovim)**: The Rose Pine theme for a comfortable and aesthetic coding environment.
- **[akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)**: An elegant and powerful buffer line (tab line) plugin.
- **[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**: A fast and easy-to-configure status line plugin.
- **[folke/which-key.nvim](https://github.com/folke/which-key.nvim)**: Displays a popup with possible keybindings following your currently entered incomplete command.
- **[gelguy/wilder.nvim](https://github.com/gelguy/wilder.nvim)**: Enhances command-line completion, search, and more.
- **[folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)**: A clean, dark Neovim theme that celebrates the lights of downtown Tokyo at night.

### Syntax & Language Support

- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**: Treesitter configurations and abstraction layer for Neovim.
- **[nvim-treesitter/nvim-treesitter-context](https://github.com/romgrk/nvim-treesitter-context)**: Shows the context of the current function/class you're in.

### Development & Debugging

- **[mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)**: A Debug Adapter Protocol client implementation for stepping through code and breakpoints.
- **[rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)**: A UI for nvim-dap.
- **[mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)**: Python specific configurations for nvim-dap.
- **[simrat39/rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)**: Extra functionality for Rust programming.
- **[mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)**: An asynchronous linter plugin.

### Language Server Protocol (LSP) & Autocompletion

- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: Quickstart configurations for the Nvim LSP client.
- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)**: Portable package manager for Neovim that installs language servers, linters, and formatters.
- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Autocompletion plugin that integrates with various sources.
- **[hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)**: Nvim-cmp source for neovim's built-in language server client.
- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)**: A snippet engine for Neovim written in Lua.
- **[hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)**: Path autocompletion for nvim-cmp.

### Utility & Miscellaneous

- **[terrortylor/nvim-comment](https://github.com/terrortylor/nvim-comment)**: Easily comment out lines or sections of code.
- **[akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)**: A Neovim plugin to persist and toggle multiple terminals.
- **[mbbill/undotree](https://github.com/mbbill/undotree)**: Visualize the undo tree to navigate through changes.
- **[github/copilot.vim](https://github.com/github/copilot.vim)**: GitHub Copilot plugin for autocompleting code.
- **[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)**: A Git wrapper so powerful, it should be illegal.
- **[averms/black-nvim](https://github.com/averms/black-nvim)**: Integration with the Black Python code formatter.
- **[rmagatti/auto-session](https://github.com/rmagatti/auto-session)**: A small automated session manager for Neovim.
- **[kmontocam/nvim-conda](https://github.com/kmontocam/nvim-conda)**: Manage Conda environments within Neovim.
- **[nvimdev/guard.nvim](#)**: *(This seems to be a custom or lesser-known plugin; a link or description would be helpful.)*

  
# The vim Language
## Buffers, Splits/Windows and Tabs

-   Buffers - buffer is an open file, which can be edited from multiple splits
-   Splits/Windows - splits aka windows are the panes which you can move through
-   Tabs - tab is a set of splits, like a tab in a terminal, people don't use it very often.

Binds

-   :e <file> - will open a new file (buffer)
-   :b <buffer> - will switch to an already opened file (buffer)
-   :vsplit - will open a vertical split
-   :split - will open a horizontal split
-   use :help tab-page to read more about tabs (they're not very necessary)

Keybinds

Often you'll see a keybind described as something like that: ggyG - which copies the entire buffer.
All the signs in the keybind are meant to be pressed as you type them.
To execute this bind you'll need to press:

-   gg - move to the top of the file
-   y - start a copy
-   shift+g - end the copy from the cursor to the end of the file

In vim you don't hold the keys in order to complete a key sequence as you type them, and you can configure the timeoutlen to make vim wait more/less between keystrokes.
Keybinds naming

You don't need to memorize keybinds as the letter stands for its action.

-   y - yank
-   p - paste

Each time where I introduce an action in this guide, I'll mark the letter I use to remember the bind.
Special Keys

-   <cmd> - is : which starts a cmd
-   <cr> - is enter
-   <Esc> - is Escape
-   <C-x> - is Ctrl+x
-   <M-x> - is alt+x
-   <M-X> - is alt+shift+x
-   <A-x> - is alt+x
-   <A-X> - is alt+shift+x
-   <leader> - is the leader key
## Leader

vim maps most of the keyboard by default, <leader> acts as a prefix for custom user binds.
Leader is remappable, the default mapping is , most vim users change it to <Space>
Help

There's a help page for everything, start using it as soon as possible, it's like man just better and for vim.
Modes

There are a lot of modes in vim, I'll cover the important ones.
To exit from each mode back to normal press Escape. I recommend remapping it to capslock, you're going to press it a lot and it will be much easier to use the pinky without moving your hands.

-   Normal - This is where you will be usually, you can move, copy in this mode, and much more
-   Insert (i) - Insert text to the buffer, you want to be in this mode only when you're actually inserting text, you don't want to move in this mode
-   Visual (v) - Select and copy/replace text
-   Visual Line (V) - Select and copy/replace text by lines
-   Command (:,/) - Inserting a command

Movements and Operators

vim is built on actions that are mostly built on 2 types, an operator and a movement.
Basic binds

    i - enter Insert mode
    a - enter insert mode After the cursor
    I - enter Insert mode at the beginning of the line
    A - enter insert mode at the end of the line (same as a but for the entire line)
    o - insert new line below
    O - insert new line above
    u - Undo, check out undotree
    Ctrl-r - Redo
    zz - Recenter the screen, there are more binds for screen actions but this is the most important one

Multiply Movement

You can multiply every movement by entering a number before the movement.
For example: 3j will jump 3 lines down
Words

    w - jump Word forward
    b - jump word Backwards
    e - jump forward to the End of the word
    ge - jump to the End of the previous word

Capital will change the behavior from word to WORD, read :help word and :help WORD to understand the differences
Generics

    0 - go to the beginning of the line
    $ - go to the end of the line
    <C-u> - go Up half a page
    <C-d> - go Down half a page
    % - jump to the pair of the bracket/quote/ifdef your cursor on
    <C-o> - jump to the previous position you jumped from (you can do it multiple times)
    <C-i> - jump to the next position you jumped to (you can do it multiple times)

Pair Movments

The standard way to jump forward to something is ] and backward is [.

Some examples

    ]m / [m - Jump to Method
    ]] / [[ - Jump to section
    } / { - Jump to paragraph
    ]c / [c - Jump to diff (Change)

I suggest to install vim-unimpaired which adds more pair movements.
Searching
Search across the file

These are not movements!

    / - to start a forward search
    ? - to start a backward search
    n - go to the Next occurrence
    N - go to the previous occurrence
    * - forward search the current word under cursor
    # - backward search the current word under cursor

I recommend to remap n and N to nzz and Nzz, zz centers the screen by the line you are on, these binds will go to the next/prev occurrence and center the screen.

map('n', 'n', 'nzz') -- Auto recenter after n
map('n', 'N', 'Nzz') -- Auto recenter after N

If you enabled opt.ignorecase you can add \C at the end of your search to re-enable case.
Quick search

These are movements! You will need to enter a char after the quick search key.

    f - jump to the next char, I remember it as Find
    F - jump to the previous char, I remember it as Find
    t - jump Till the next char (1 char before the occurrence)
    T - jump Till the prev char (1 char after the occurrence)

These movements are very useful to manipulate text in the same line. This is the reason I enable opt.wrap in vim.

I highly recommend installing clever-f.vim it will help you get used to these awesome movements fast.
Operators

The main ones

    y - Yank (copy)
    d - Delete
    c - Change, delete the text and enters insert mode
    < - remove indentation (left)
    > - add indentation (right)
    = - auto indent
    gc - Comment/Uncomment, done with Comment.nvim

Capital (shift) will apply the operation starting from the cursor to the end of the line, e.g: D deletes the line from the cursor to the end of the line.
Repeating the operator key will apply the operation for the entire line, e.g: yy yanks the entire current line.
Action

Action is an operator + movement
For example:

    y3k - yank 2 lines above the cursor, including the current line.
    ct, - change the text until ,, very useful to change function arguments and more.

This is why you must have relativenumber on, it will make your life much easier.
"Special" actions

    Hit the operator twice to activate it on the current line. yy will yank the entire line you are on.
    Shift+operator to activate the operator from the cursor the end of the line. C will change the line from the cursor to the end.

One char actions

Actions without movement

    x - delete the char you are on.
    X - delete 1 char before the cursor.
    r - Replace 1 char

How should I remember all those binds?

Think of a key sequence as an English sentence.

For example: when I'm using y3j/y3<Enter> I'll think of it as yank 3 down, in my mind I "speak" with the editor rather than remembering which keys to press.


# tmux shortcuts & cheatsheet

start new:

    tmux

start new with session name:

    tmux new -s myname

attach:

    tmux a  #  (or at, or attach)

attach to named:

    tmux a -t myname

list sessions:

    tmux ls

<a name="killSessions"></a>kill session:

    tmux kill-session -t myname

<a name="killAllSessions"></a>Kill all the tmux sessions:

    tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill

In tmux, hit the prefix `ctrl+b` (my modified prefix is ctrl+a) and then:

## List all shortcuts
to see all the shortcuts keys in tmux simply use the `bind-key ?` in my case that would be `CTRL-B ?`

## Sessions

    :new<CR>  new session
    s  list sessions
    $  name session

## <a name="WindowsTabs"></a>Windows (tabs)

    c  create window
    w  list windows
    n  next window
    p  previous window
    f  find window
    ,  name window
    &  kill window

## <a name="PanesSplits"></a>Panes (splits) 

    %  vertical split
    "  horizontal split
    
    o  swap panes
    q  show pane numbers
    x  kill pane
    +  break pane into window (e.g. to select text by mouse to copy)
    -  restore pane from window
    ⍽  space - toggle between layouts
    <prefix> q (Show pane numbers, when the numbers show up type the key to goto that pane)
    <prefix> { (Move the current pane left)
    <prefix> } (Move the current pane right)
    <prefix> z toggle pane zoom

## <a name="syncPanes"></a>Sync Panes 

You can do this by switching to the appropriate window, typing your Tmux prefix (commonly Ctrl-B or Ctrl-A) and then a colon to bring up a Tmux command line, and typing:

```
:setw synchronize-panes
```

You can optionally add on or off to specify which state you want; otherwise the option is simply toggled. This option is specific to one window, so it won’t change the way your other sessions or windows operate. When you’re done, toggle it off again by repeating the command. [tip source](http://blog.sanctum.geek.nz/sync-tmux-panes/)


## Resizing Panes

You can also resize panes if you don’t like the layout defaults. I personally rarely need to do this, though it’s handy to know how. Here is the basic syntax to resize panes:

    PREFIX : resize-pane -D (Resizes the current pane down)
    PREFIX : resize-pane -U (Resizes the current pane upward)
    PREFIX : resize-pane -L (Resizes the current pane left)
    PREFIX : resize-pane -R (Resizes the current pane right)
    PREFIX : resize-pane -D 20 (Resizes the current pane down by 20 cells)
    PREFIX : resize-pane -U 20 (Resizes the current pane upward by 20 cells)
    PREFIX : resize-pane -L 20 (Resizes the current pane left by 20 cells)
    PREFIX : resize-pane -R 20 (Resizes the current pane right by 20 cells)
    PREFIX : resize-pane -t 2 -L 20 (Resizes the pane with the id of 2 left by 20 cells)
    
## Copy mode:

Pressing PREFIX [ places us in Copy mode. We can then use our movement keys to move our cursor around the screen. By default, the arrow keys work. we set our configuration file to use Vim keys for moving between windows and resizing panes so we wouldn’t have to take our hands off the home row. tmux has a vi mode for working with the buffer as well. To enable it, add this line to .tmux.conf:

    setw -g mode-keys vi

With this option set, we can use h, j, k, and l to move around our buffer.

To get out of Copy mode, we just press the ENTER key. Moving around one character at a time isn’t very efficient. Since we enabled vi mode, we can also use some other visible shortcuts to move around the buffer.

For example, we can use "w" to jump to the next word and "b" to jump back one word. And we can use "f", followed by any character, to jump to that character on the same line, and "F" to jump backwards on the line.

       Function                vi             emacs
       Back to indentation     ^              M-m
       Clear selection         Escape         C-g
       Copy selection          Enter          M-w
       Cursor down             j              Down
       Cursor left             h              Left
       Cursor right            l              Right
       Cursor to bottom line   L
       Cursor to middle line   M              M-r
       Cursor to top line      H              M-R
       Cursor up               k              Up
       Delete entire line      d              C-u
       Delete to end of line   D              C-k
       End of line             $              C-e
       Goto line               :              g
       Half page down          C-d            M-Down
       Half page up            C-u            M-Up
       Next page               C-f            Page down
       Next word               w              M-f
       Paste buffer            p              C-y
       Previous page           C-b            Page up
       Previous word           b              M-b
       Quit mode               q              Escape
       Scroll down             C-Down or J    C-Down
       Scroll up               C-Up or K      C-Up
       Search again            n              n
       Search backward         ?              C-r
       Search forward          /              C-s
       Start of line           0              C-a
       Start selection         Space          C-Space
       Transpose chars                        C-t

## Misc

    d  detach
    t  big clock
    ?  list shortcuts
    :  prompt

## Configurations Options:

    # Mouse support - set to on if you want to use the mouse
    * setw -g mode-mouse off
    * set -g mouse-select-pane off
    * set -g mouse-resize-pane off
    * set -g mouse-select-window off

    # Set the default terminal mode to 256color mode
    set -g default-terminal "screen-256color"

    # enable activity alerts
    setw -g monitor-activity on
    set -g visual-activity on

    # Center the window list
    set -g status-justify centre

    # Maximize and restore a pane
    unbind Up bind Up new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp
    unbind Down
    bind Down last-window \; swap-pane -s tmp.1 \; kill-window -t tmp

# Customize Alacritty :
https://ostechnix.com/alacritty-terminal-emulator/

# Compare fonts for code :
https://www.codingfont.com/
