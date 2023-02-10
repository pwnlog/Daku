local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("configuration.applications")

-- *********************************
-- *********************************
-- *********************************
--		  	  AWESOME MENU BAR
-- *********************************
-- *********************************
-- *********************************

--- Awesome Submenu
myawesomemenu = {
    { "  Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "󰗚  Manual", terminal .. " -e man awesome" },
    { "  Edit config", editor_cmd .. " " .. awesome.conffile },
    { "  Restart", awesome.restart },
    { "󰿅  Quit", function() awesome.quit() end },
 }
 
 -- Menu Appearance
 beautiful.font = 'Iosevka Nerd Font 10'
 beautiful.menu_height=20
 beautiful.menu_width=180
 beautiful.menu_bg_normal="#14181d"
 beautiful.menu_bg_focus="#8ca1a5"
 beautiful.menu_fg_focus="#1e252c"
 
 -- Hotkeys Appearance
 beautiful.hotkeys_bg='#14181d'
 beautiful.hotkeys_font='Iosevka Nerd Font 10'
 beautiful.hotkeys_description_font='Iosevka Nerd Font 10'
  
 -- Menu Items
 mymainmenu = awful.menu({ items = { { "  Awesome", myawesomemenu },
                                     { "  Open Terminal", terminal },
                                     { "  Browser", "firefox" },
                                     { "󰨞  Editor", "code" },
                                     { "  Files Manager", "thunar" },
                                     { "󱘖  Network Manager", "nm-connection-editor" },
                                     { "󱙳  Wireshark", "wireshark" },
                                     { "󰯊  BurpSuite", "burp" },
                                     { "󰩄  BloodHound", "bloodhound" },
                                     { "󰨊  PowerShell", "kitty pwsh" }
                                   }
                         })
 -- Widget Launcher
 mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                      menu = mymainmenu })