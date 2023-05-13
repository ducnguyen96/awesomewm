-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")

local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

require("./consts")

-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
 }
 
local mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, image = config_dir .. "images/icons/nixos.png" },
                                     { "open terminal", terminal }
                                   }
                         })
 
local mylauncher = awful.widget.launcher({ image =  config_dir .. "images/icons/nixos.png", menu = mymainmenu })

return mylauncher