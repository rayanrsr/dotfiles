<div align="center">
    <h1>Tmux</h1>
</div>



# Why Tmux ?
- Terminal Multiplexing: Tmux allows users to split a single terminal into multiple panes, each capable of running different commands. This enhances productivity by enabling multitasking within a single terminal window.
- Session Management: Tmux supports the creation and management of sessions, allowing users to detach from a session and later reattach, even from a different location. This feature is particularly useful for remote development or for persisting work across different sessions.
- Customization and Scripting: Tmux is highly customizable through a configuration file, enabling users to define key bindings, customize the status bar, and adjust other settings. It also supports scripting, allowing automation and integration with other tools.
- Remote Accessibility: Tmux facilitates remote collaboration and access to a shared terminal session. Multiple users can connect to the same Tmux session simultaneously, making it a valuable tool for pair programming or remote assistance.
- Resilience and Continuity: In case of a network disconnection or system crash, Tmux sessions remain active and recoverable. This ensures that work is not lost, providing a level of resilience and continuity in terminal-based workflows.

# Explanation of the configuration file
    Terminal Overrides: Set terminal overrides for xterm.
    Tmux Plugin Manager (TPM): Load TPM and various plugins for enhancing tmux functionality.
    Mouse Support: Enable mouse support.
    Base Index: Set base index values for windows and panes.
    Renumber Windows: Automatically renumber windows when one is closed.
    Status Bar Position: Set the status bar position to the top.
    Window Navigation Keybindings: Use Alt + H/L to navigate to the previous/next window.
    Copy Mode Settings: Use vi mode for copy mode with additional key bindings.
    Open Pane in Current Directory: Bindings for opening a new pane or window in the current directory.
    Launch Tmux Plugin Manager: Run TPM to install and manage tmux plugins.

Feel free to customize these settings according to your preferences and workflow. If you have specific questions about any part of the configuration, feel free to ask!

# Explanation of Keybindings:

    Alt + H (Meta + H): Switch to the previous window.
    Alt + L (Meta + L): Switch to the next window.
    Ctrl + b + 1, 2, 3, ... (Customizable): Switch to windows by index. Currently commented out; uncomment and customize if needed.
    Copy Mode (Vi Mode):
        v: Begin selection in copy mode.
        y: Copy the selected text.
        r: Toggle rectangle selection.
    Ctrl + b + c (Customizable): Create a new window in the current directory.
    Ctrl + b + s (Customizable): Split the current window horizontally in the current directory.
    Ctrl + b + v (Customizable): Split the current window vertically in the current directory.

Feel free to modify these keybindings according to your preferences. If you have specific questions about any particular keybinding or need further clarification, let me know!

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
