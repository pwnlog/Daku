local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local dpi = xresources.apply_dpi
local clm = { client = client, mouse = mouse }

local _window = {}
local floating_resize = dpi(10)
local tiling_resize = 0.05

-- *********************************
-- *********************************
-- *********************************
--		  	    RESIZE
-- *********************************
-- *********************************
-- *********************************

function _window.resize_window(w, direction)
	if w and w.floating or awful.layout.get(clm.mouse.screen) == awful.layout.suit.floating then
		if direction == "up" then
			w:relative_move(0, 0, 0, -floating_resize)
		elseif direction == "down" then
			w:relative_move(0, 0, 0, floating_resize)
		elseif direction == "left" then
			w:relative_move(0, 0, -floating_resize, 0)
		elseif direction == "right" then
			w:relative_move(0, 0, floating_resize, 0)
		end
	elseif awful.layout.get(clm.mouse.screen) ~= awful.layout.suit.floating then
		if direction == "up" then
			awful.client.incwfact(-tiling_resize)
		elseif direction == "down" then
			awful.client.incwfact(tiling_resize)
		elseif direction == "left" then
			awful.tag.incmwfact(-tiling_resize)
		elseif direction == "right" then
			awful.tag.incmwfact(tiling_resize)
		end
	end
end

return _window