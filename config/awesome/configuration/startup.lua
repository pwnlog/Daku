local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

-- *********************************
-- *********************************
-- *********************************
--		  	 STARTUP APPS
-- *********************************
-- *********************************
-- *********************************

local function startup_apps()
    -- Enable VMware Guest Tools
    awful.util.spawn_with_shell("vmware-user-suid-wrapper --no--startup-id")
    -- Start Picom
    awful.util.spawn_with_shell("killall picom; picom --config ~/.config/picom/picom.conf -b")
    -- Start Wallpaper with reload enabled upon X11 events
    awful.util.spawn_with_shell("killall xeventbind; xeventbind resolution ~/.fehbg")
    awful.util.spawn_with_shell("killall feh; ~/.fehbg")
    -- Start Polybar with reload enabled upon changes
    awful.util.spawn_with_shell("~/.config/polybar/polybar.sh --daku") 
end

startup_apps()