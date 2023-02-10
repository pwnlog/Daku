local awful = require("awful")

-- *********************************
-- *********************************
-- *********************************
-- 			     TAGS
-- *********************************
-- *********************************
-- *********************************

screen.connect_signal("request::desktop_decoration", function(s)
	awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.suit.tile)
end)