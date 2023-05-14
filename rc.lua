-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local theme = "pastel" -- available: pastel
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "/theme.lua")

-- Error handling
require("./error-handling")()

-- Layouts
require("./layouts")

-- Wibar
require("./wibar")

-- Set keys
require("./keys")

-- Rules
require("./rules")

-- Sigals
require("./signals")

awful.spawn.with_shell("xrandr --output DP-0 --rotate left")