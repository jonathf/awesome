local awful = require("awful")
local gears = require("gears")
local lain  = require("lain")
local wibox = require("wibox")
local vicious = require("vicious")
local beautiful = require("beautiful")

local markup = lain.util.markup
os.setlocale(os.getenv("LANG")) -- to localize the clock

local function set_wallpaper(screen)
    gears.wallpaper.maximized(beautiful.wallpaper, screen, true)
end
-- reset wallpaper on each screen resize:
screen.connect_signal("preoperty::geometry", set_wallpaper)

-- buttons for tags and tasks:
local taglist_buttons = awful.util.table.join(
    awful.button({}, 1, function(t) t:view_only() end)
)
local tasklist_buttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then c.minimized = true
        else
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            client.focus = c
            c:raise()
        end
    end)
)

-- layout list:
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile.left
}
lain.layout.termfair.center.nmaster = 3

local sep = wibox.widget.textbox(" ")

-- clock widget:
local mytextclock = wibox.widget.textclock(
    markup("#8c9440", "%a %d.%m %H:%M"))
mytextclock.font = theme.font

-- battery widget:
mybattery = wibox.widget.textbox()
vicious.register(
    mybattery,
    vicious.widgets.bat,
    function(widget, args)
        return markup("#de935f", args[1] .. args[2])
    end,
    nil,
    "BAT0"
)

-- volume widget:
vicious.cache(vicious.widgets.volume)
myvolume = wibox.widget.textbox()
vicious.register(
    myvolume,
    vicious.widgets.volume,
    markup("#5e8d87", "$1%"),
    nil,
    "Master"
)

-- on connect of each new screen:
awful.screen.connect_for_each_screen(function(screen)

    -- wallpaper
    set_wallpaper(screen)

    -- wibox
    local layouts = wibox.layout.align.horizontal()

    local layout = wibox.layout.fixed.horizontal()
    awful.tag({'1', '2', '3', '4', '5', '6', '7', '8', '9'}, screen, awful.layout.suit.max)
    screen.mytaglist = awful.widget.taglist(
        screen, awful.widget.taglist.filter.noempty, taglist_buttons)

    screen.mytasklist = awful.widget.tasklist(
        screen,
        awful.widget.tasklist.filter.currenttags,
        tasklist_buttons,
        {tasklist_disable_icon=true, align="center"}
    )
    layouts:set_middle(screen.mytasklist)

    local layout = wibox.layout.fixed.horizontal()
    layout:add(wibox.widget.systray())
    layout:add(sep)
    layout:add(screen.mytaglist)
    layouts:set_left(layout)

    local layout = wibox.layout.fixed.horizontal()
    layout:add(mybattery)
    layout:add(sep)
    layout:add(myvolume)
    layout:add(sep)
    layout:add(mytextclock)
    layout:add(sep)
    layout:add(sep)
    layouts:set_right(layout)

    screen.mywibox = awful.wibar({position="top", screen=screen})
    screen.mywibox:set_widget(layouts)
end)


-- Rules
awful.rules.rules = {{
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        -- screen = awful.screen.focused
    }
}, {
    rule={class="plugin-container"}, properties={floating=true, focus=yes}
}, {
    rule={class="Plugin-container"}, properties={floating=true, focus=yes}
}, {
    rule={
        class="libreoffice"},
        properties={floating=false, maximized=true, focus=yes
    }
}}

-- Prevent clients from being unreachable after screen count changes.
client.connect_signal("manage", function (c, startup)
    c:keys(clientkeys)
    c:buttons(clientbuttons)
    if awesome.startup and not c.size_hints.user_position and
            not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- (un)focus rules:
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
