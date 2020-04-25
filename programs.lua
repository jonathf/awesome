local awful = require("awful")

terminal = "urxvt --meta8"
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Window transparency
awful.spawn.once("xcompmgr -cF")

-- Keyboard layout remap: capslock->escape, escape->F12
awful.spawn.once("setxkbmap -layout no")
awful.spawn.once("setxkbmap -option caps:escape")
awful.spawn.once("xmodmap -e \"keycode 9 = F12\"")

-- Applets
awful.spawn.once('nm-applet')
awful.spawn.once('blueman-applet')
