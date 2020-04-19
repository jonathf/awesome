local awful = require("awful")

terminal = "urxvt --meta8"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Window transparency
awful.util.spawn_with_shell("xcompmgr -cF &")

-- Keyboard layout remap: capslock->escape, escape->F12
awful.util.spawn_with_shell("setxkbmap -layout no")
awful.util.spawn_with_shell("setxkbmap -option caps:escape")
awful.util.spawn_with_shell("xmodmap -e \"keycode 9 = F12\"")

-- Applets
awful.util.spawn_with_shell("if [[ ! `pgrep nm-applet` ]]; then nm-applet --indicator & fi")
awful.util.spawn_with_shell("if [[ ! `pgrep blueman-applet` ]]; then blueman-applet & fi")
awful.util.spawn_with_shell("if [[ ! `pgrep xfce4-power-manager` ]]; then xfce4-power-manager & fi")
awful.util.spawn_with_shell("if [[ ! `pgrep pa-applet` ]]; then pa-applet & fi")
