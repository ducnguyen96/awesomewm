-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Error handling
require("./error-handling")()

-- Layouts
require("./layouts")

-- Themes define colours, icons, font and wallpapers.
local themes = {
    "pastel", -- 1
}

-- change this number to use the corresponding theme
local theme = themes[1]
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "-theme.lua")

-- Wibar
require("./wibar")

-- Set keys
require("./keys")
root.keys(globalkeys)

-- Rules
require("./rules")

-- Sigals
require("./signals")
