local awful = require("awful")

terminal = "urxvt --meta8"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Window transparency
awful.spawn.with_shell("xcompmgr -cF &")

-- Keyboard layout remap: capslock->escape, escape->F12
awful.spawn.with_shell("setxkbmap -layout no")
awful.spawn.with_shell("setxkbmap -option caps:escape")
awful.spawn.with_shell("xmodmap -e \"keycode 9 = F12\"")

-- Applets
awful.spawn.with_shell('nm-applet &')
awful.spawn.with_shell('blueman-applet &')
