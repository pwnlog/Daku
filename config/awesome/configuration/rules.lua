local awful = require("awful")
local beautiful = require("beautiful")
local ruled = require("ruled")

-- *********************************
-- *********************************
-- *********************************
--		  	     RULES
-- *********************************
-- *********************************
-- *********************************

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Bash command: xprop WM_CLASS

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { 
                "copyq",
                "pinentry" 
            },
            class    = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "Tor Browser",
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                --"Nsxiv",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Nsxiv Floating
    ruled.client.append_rule {
        rule = { class = "Nsxiv" },
        properties = {
            floating  = true,
            placement = awful.placement.centered,
            width     = 640,
            height    = 480,
        },
    }

    -- Xfce4 App Finder Floating
    ruled.client.append_rule {
        rule = { class = "Xfce4-appfinder" },
        properties = {
            floating  = true,
            placement = awful.placement.up,
            width     = 640,
            height    = 40,
        },
    }

    -- Nm Connection Editor Floating
    ruled.client.append_rule {
        rule = { class = "Nm-connection-editor" },
        properties = {
            floating  = true,
            placement = awful.placement.centered,
            width     = 640,
            height    = 40,
        },
    }

    -- Visual Studio Code Floating False
    ruled.client.append_rule {
        rule = { class = "Code" },
        properties = {
            floating  = false,
            --placement = awful.placement.centered,
        },
    }


end)