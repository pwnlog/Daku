pcall(require, "luarocks.loader")
local gears = require("gears")
local beautiful = require("beautiful")
local naughty = require("naughty")

--local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
--beautiful.init(theme_dir .. "theme.lua")

-- *********************************
-- *********************************
-- *********************************
--		     ERROR HANDLING
-- *********************************
-- *********************************
-- *********************************

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- *********************************
-- *********************************
-- *********************************
--		     CONFIGURATION
-- *********************************
-- *********************************
-- *********************************

require("configuration")

-- *********************************
-- *********************************
-- *********************************
--		         UI
-- *********************************
-- *********************************
-- *********************************

--require("ui")

-- *********************************
-- *********************************
-- *********************************
--		      MODULES
-- *********************************
-- *********************************
-- *********************************

require("modules")
