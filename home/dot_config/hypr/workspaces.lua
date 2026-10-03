-- Drives workspace name (Noctalia bar), monitor, layout, persistence, and
-- gaming/fullscreen perks for ws5. Replaces the exec-once
-- `hyprctl renameworkspace` chain and the workspace lines that used to be
-- split across hyprland.conf, monitors.conf, and windowrules.conf.
local NO_DECO = { gaps_in = 0, gaps_out = 0, no_border = true, no_rounding = true, no_shadow = true }

local workspaces = {
    { id =  1, icon = "󰆍", label = "Terminal", monitor = "DP-1", layout = "scrolling", persistent = true },
    { id =  2, icon = "󰖟", label = "Browser",  monitor = "DP-2",                       persistent = true },
    { id =  3, icon = "󰨞", label = "Code",     monitor = "DP-1", layout = "scrolling", persistent = true },
    { id =  4, icon = "󰭹", label = "Chat",     monitor = "DP-2", layout = "scrolling", persistent = true },
    { id =  5, icon = "󰊗", label = "Games",    monitor = "DP-1",                       persistent = true, extras = NO_DECO },
    { id =  6, icon = "󰒍", label = "Vault",    monitor = "DP-2", layout = "scrolling", persistent = true },
    { id =  7, icon = "󰚩", label = "Hermes",   monitor = "DP-2", layout = "scrolling", persistent = true },
    { id =  8, icon = "󰀻", label = "Misc",     monitor = "DP-2" },
    { id =  9, icon = "󰀻", label = "Misc",     monitor = "DP-2" },
    { id = 10, icon = "󰀻", label = "Misc" },
}

for _, w in ipairs(workspaces) do
    local spec = {
        workspace    = tostring(w.id),
        default_name = string.format("%s %d: %s", w.icon, w.id, w.label),
        monitor      = w.monitor,
        layout       = w.layout,
        persistent   = w.persistent,
    }
    if w.extras then
        for k, v in pairs(w.extras) do spec[k] = v end
    end
    hl.workspace_rule(spec)
end
