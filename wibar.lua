-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

-- Widget and layout library
local wibox = require("wibox")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")

-- {{{ Wibar
-- Create a textclock widget
local mytextclock = wibox.widget.textclock()
local cw = calendar_widget({
    theme = 'nord',
    previous_month_button = 1,
    next_month_button = 3
})
mytextclock:connect_signal("button::press", 
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
    
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        expand = "none",
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            require("./launcher"),
            s.mytaglist,
            s.mypromptbox,
        },
        mytextclock,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            cpu_widget({
                idth = 70,
                step_width = 2,
                step_spacing = 0,
                color = '#38785f'
            }),
            ram_widget({
                color_free = '#fffff344',
                color_used = '#633bd9',
            }),
            brightness_widget{
                type = 'arc',
                program = 'brightnessctl',
                step = 10,
                colors = {'#633bd9'}        
            },
            volume_widget{
                widget_type = 'arc',
                thickness = 1,
                main_color = '#633bd9',
                mute_color = '#f77845'
            },
            batteryarc_widget({
                show_current_level = true,
                arc_thickness = 1,
                main_color = '#633bd9',
            }),
            -- s.mylayoutbox,
        },
    }
end)
-- }}}

return {
    volume_widget = volume_widget,
    brightness_widget= brightness_widget
}