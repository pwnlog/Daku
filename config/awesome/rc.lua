-- Currently in development, still have to make some tweaks!

-- *********************************
-- *********************************
-- *********************************
--		LUAROCKS PREREQUISITE CHECK
-- *********************************
-- *********************************
-- *********************************

-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- *********************************
-- *********************************
-- *********************************
--		  			LIBRARIES
-- *********************************
-- *********************************
-- *********************************

-- @DOC_REQUIRE_SECTION@

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
-- local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local hotkeys_popup2 = require("awful.hotkeys_popup.widget")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- *********************************
-- *********************************
-- *********************************
--		  		ERROR HANDLING
-- *********************************
-- *********************************
-- *********************************

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
-- @DOC_ERROR_HANDLING@

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
--		  VARIABLES DEFINITIONS
-- *********************************
-- *********************************
-- *********************************

-- @DOC_LOAD_THEME@

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "default/theme.lua")

-- @DOC_DEFAULT_APPLICATIONS@
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- *********************************
-- *********************************
-- *********************************
--		  	 AWESOME MENU BAR
-- *********************************
-- *********************************
-- *********************************

-- @DOC_MENU@
-- Create a launcher widget and a main menu

-- Awesome Submenu
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
--beautiful.menu_fg_normal="#1e252c"
beautiful.menu_fg_focus="#1e252c"

-- Hotkeys Appearance
beautiful.hotkeys_bg='#14181d'
beautiful.hotkeys_font='Iosevka Nerd Font 10'
beautiful.hotkeys_description_font='Iosevka Nerd Font 10'

-- Gap Between Windows
beautiful.useless_gap = 5

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

-- *********************************
-- *********************************
-- *********************************
--		  	 MENU BAR UTILS
-- *********************************
-- *********************************
-- *********************************

-- Set the terminal for applications that require it

-- menubar.utils.terminal = terminal 

-- *********************************
-- *********************************
-- *********************************
--		  	  TAG LAYOUTS
-- *********************************
-- *********************************
-- *********************************

-- @DOC_LAYOUT@
-- Table of layouts to cover with awful.layout.inc, order matters.

-- Q: What is this?
-- A: Windows Tile,Floating,Fair,Spiral,Max,Magnifier,etc...

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        awful.layout.suit.floating,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)


-- *********************************
-- *********************************
-- *********************************
--		                    WALLPAPER (REPLACED WITH Feh)
-- *********************************
-- *********************************
-- *********************************

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = wibox.container.tile,
        }
    }
end)

-- *********************************
-- *********************************
-- *********************************
--		                    WIBAR (NOT USED)
-- *********************************
-- *********************************
-- *********************************

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Widget Colors
    --awful.widget.colors = {}

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
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
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    --[[
    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                s.mytaglist,
                s.mypromptbox,
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mykeyboardlayout,
                wibox.widget.systray(),
                mytextclock,
                s.mylayoutbox,
            },
        }
    }
    --]]
end)

-- *********************************
-- *********************************
-- *********************************
--		  	  MOUSE BINDINGS
-- *********************************
-- *********************************
-- *********************************

-- @DOC_ROOT_BUTTONS@

awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

-- *********************************
-- *********************************
-- *********************************
--		  	KEYBOARD KEYBINDINGS
-- *********************************
-- *********************************
-- *********************************

-- @DOC_GLOBAL_KEYBINDINGS@

--[[
Keys:
modkey		Super (Windows Key)
shift       Shift_L (0x32),  Shift_R (0x3e)
lock        Caps_Lock (0x42)
control     Control_L (0x25),  Control_R (0x69)
mod1        Alt_L (0x40),  Alt_R (0x6c),  Meta_L (0xcd)
mod2        Num_Lock (0x4d)
mod3        Super_R (0x86),  Super_R (0x87)
mod4        Super_L (0x85),  Super_L (0xce),  Hyper_L (0xcf)
mod5        ISO_Level3_Shift (0x5c),  Mode_switch (0xcb)
--]]

--[[
-- Custom Added Keys Help Widget
local mouse_keys = {
    ["mouse: floating"] = {
        modifiers  = { modkey },
        keys = {
            ['Left Click']="Move floating window",
            ['Right Click']="Resize floating window",
        }
    }
}

hotkeys_popup2.add_hotkeys(mouse_keys)
--]]



-- General Awesome keys

awful.keyboard.append_global_keybindings({
    -- Show Keyboard Shortcuts Help
    awful.key(
        { modkey },
        "s",
        hotkeys_popup.show_help,
        {description="show help", group="awesome"}
    ),
    
    -- Show AwesomeWM menu
    awful.key(
        { modkey },
        "c",
        function () 
            mymainmenu:show() 
        end,
        {description = "show main menu", group = "awesome"}
    ),
    
    -- Reload AwesomeWM
    awful.key(
        { modkey, "Mod1" },
        "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    
    -- Quit AwesomeWM
    awful.key(
        { modkey, "Mod1" },
        "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    
    --[[
    -- Run Lua Code
    awful.key(
    { modkey },
    "x",
    function ()
	    awful.prompt.run {
		    prompt       = "Run Lua code: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
    end,
    {description = "lua execute prompt", group = "awesome"}
    ),
    --]]

    -- Open Terminal (Kitty)
    awful.key(
        { modkey },
        "Return",
        function () 
            awful.spawn(terminal) 
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    
    -- Run Launcher (Rofi)
    awful.key(
        { modkey },
        "d",
        function () 
            -- awful.screen.focused().mypromptbox:run() 
            awful.spawn("rofi -theme ~/.config/rofi/launcher.rasi -show drun")
        end,
        {description = "run prompt", group = "launcher"}
    ),
    
    --[[
    -- Show the menubar
    awful.key(
    { modkey },
    "p",
    function () 
        menubar.show() 
    end,
    {description = "show the menubar", group = "launcher"}
    ),
    --]]
    
    -- Lockscreen
    awful.key(
        { "Mod1", "Shift" },
        "x",
        function () 
            awful.spawn("i3lock-fancy") 
        end,
        {description = "activate lock screen", group = "launcher"}
    ),

    -- Screenshot  
    awful.key(
        { },
        "Print",
        function () 
            awful.spawn("flameshot gui") 
        end,
        {description = "take a screenshot with flameshot", group = "launcher"}
    ),
    
})

-- Scripts keybindings

awful.keyboard.append_global_keybindings({
	-- Wallpaper Selector Script
	awful.key(
        {modkey, "Mod1" },
        "e",
        function ()
            awful.util.spawn_with_shell("nsxiv -t ~/Pictures/Wallpapers/")
        end,
        {description = "open wallpaper selector", group = "scripts"}
	),
	
	-- Change Corners Windows and Polybar
    awful.key(
	{modkey, "Mod1" },
	"b",
	function () 
        awful.util.spawn_with_shell("/usr/local/bin/change-corners") 
    end,
	{description = "change windows corners (square or rounded)", group = "scripts"}
	),
	
	-- Change Wallpapers On The Fly
	awful.key(
        {modkey, "Mod1" },
        "w",
        function () 
            awful.util.spawn_with_shell("/usr/local/bin/wallpaper-changer") 
        end,
        {description = "change wallpapers on the fly", group = "scripts"}
	),

    -- Powermenu (Rofi)
    awful.key(
        {modkey},
        "q",
        function () 
            awful.spawn("/usr/local/bin/powermenu") 
        end,
        {description = "open rofi powermenu", group = "scripts"}
    ),
	
})

-- Tags related keybindings

awful.keyboard.append_global_keybindings({
    -- View previous tag
    awful.key(
        { modkey },
        "Left",
        awful.tag.viewprev,
        {description = "view previous tag/workspace", group = "tag"}
    ),
    
    -- View next tag
    awful.key(
        { modkey },
        "Right",
        awful.tag.viewnext,
        {description = "view next tag/workspace", group = "tag"}
    ),
    
    -- Restore tag history
    awful.key(
        { modkey },
        "Escape",
        awful.tag.history.restore,
        {description = "go back to the previous tag/workspace", group = "tag"}
    ),
})

-- Focus related keybindings

awful.keyboard.append_global_keybindings({
    -- Focus next by index
    awful.key(
        { modkey },
        "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next window by index", group = "client"}
    ),

    -- Focus previous by index
    awful.key(
        { modkey },
        "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous window by index", group = "client"}
    ),

    -- Focus on previous by history
    awful.key(
        { modkey },
        "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back to previous window", group = "client"}
    ),
    
    -- Focus the next screen
    awful.key(
        { modkey, "Control" },
        "j",
        function () 
            awful.screen.focus_relative( 1) 
        end,
        {description = "focus the next screen", group = "screen"}
    ),
    
    -- Focus the previous screen
    awful.key(
        { modkey, "Control" },
        "k",
        function () 
            awful.screen.focus_relative(-1) 
        end,
        {description = "focus the previous screen", group = "screen"}
    ),
    
    -- Restore minimized client
    awful.key(
        { modkey, "Control" },
        "n",
        function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                c:activate { raise = true, context = "key.unminimize" }
                end
        end,
        {description = "restore minimized window", group = "client"}
    ),

})

-- Layout related keybindings

awful.keyboard.append_global_keybindings({
    -- Swap window/tag with next client by index
    awful.key(
        { modkey, "Shift" },
        "j",
        function ()
            awful.client.swap.byidx(  1)
        end,
        {description = "swap with next window client by index", group = "client"}
    ),
    
    -- Swap window/tag with previous client by index
    awful.key(
        { modkey, "Shift" },
        "k",
        function ()
            awful.client.swap.byidx( -1)
        end,
        {description = "swap with previous window client by index", group = "client"}
    ),
    
    -- Jump to urgent client
    awful.key(
        { modkey },
        "u",
        awful.client.urgent.jumpto,
        {description = "jump to urgent window client", group = "client"}
    ),
    
    -- Increase master width factor
    awful.key(
        { modkey },
        "l",
        function () 
            awful.tag.incmwfact( 0.05)
        end,
        {description = "increase master window width factor", group = "layout"}
    ),
    
    -- Decrease master width factor
    awful.key(
        { modkey },
        "h",
        function () 
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master window width factor", group = "layout"}
    ),
    
    -- Increase the number of master clients
    awful.key(
        { modkey, "Shift" },
        "h",
        function () 
            awful.tag.incnmaster( 1, nil, true) 
        end,
        {description = "increase the number of window master clients", group = "layout"}
    ),
    
    -- Decrease the number of master clients
    awful.key(
        { modkey, "Shift" },
        "l",
        function () 
            awful.tag.incnmaster(-1, nil, true) 
        end,
        {description = "decrease the number of window master clients", group = "layout"}
    ),

    -- Increase the number of columns
    awful.key(
        { modkey, "Control" },
        "h",
        function () 
            awful.tag.incncol( 1, nil, true)
        end,
        {description = "increase the number of columns in windows", group = "layout"}
    ),
    
    -- Decrease the number of columns
    awful.key(
        { modkey, "Control" },
        "l",
        function () 
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns in windows", group = "layout"}
    ),
    
    -- Select next layout
    awful.key(
        { modkey },
        "space",
        function () 
            awful.layout.inc( 1)
        end,
        {description = "select next layout", group = "layout"}
    ),
    
    -- Select previous layout
    awful.key(
        { modkey, "Shift" },
        "space",
        function () 
            awful.layout.inc(-1)
        end,
        {description = "select previous layout", group = "layout"}
    ),

})

-- @DOC_NUMBER_KEYBINDINGS@

awful.keyboard.append_global_keybindings({
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag/workspace",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag/workspace",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag/workspace",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag/workspace",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function (index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    }
})

-- @DOC_CLIENT_BUTTONS@

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

-- @DOC_CLIENT_KEYBINDINGS@

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- Toggle fullscreen
        awful.key(
            { modkey },
            "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen on window", group = "client"}
        ),

        -- Close window
        awful.key(
            { modkey },
            "w",
            function (c) 
                c:kill()
            end,
            {description = "close window", group = "client"}
        ),
        
        -- Toggle floating
        awful.key(
            { modkey, "Control" },
            "space",
            awful.client.floating.toggle                     ,
            {description = "toggle floating window", group = "client"}
        ),
        
        -- Move to master
        awful.key(
            { modkey, "Control" },
            "Return",
            function (c) 
                c:swap(awful.client.getmaster())
            end,
            {description = "move to master", group = "client"}
        ),
        
        -- Move to screen
        awful.key(
            { modkey },
            "o",
            function (c) 
                c:move_to_screen()
            end,
            {description = "move to screen", group = "client"}
        ),
        
        -- Toggle keep on top
        awful.key(
            { modkey },
            "t",
            function (c) 
                c.ontop = not c.ontop
            end,
            {description = "toggle keep window on top", group = "client"}
        ),
        
        -- Minimize window
        awful.key(
            { modkey },
            "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end,
            {description = "minimize window", group = "client"}
        ),
        
        -- Unmaximize window
        awful.key(
            { modkey },
            "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end,
            {description = "(un)maximize window", group = "client"}
        ),
        
        -- Unmaximize vertically
        awful.key(
            { modkey, "Control" },
            "m",
            function (c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            {description = "(un)maximize window vertically", group = "client"}
        ),
        
        -- Unmaximize horizontally
        awful.key(
            { modkey, "Shift" },
            "m",
            function (c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            {description = "(un)maximize window horizontally", group = "client"}
        ),

    })
end)

-- *********************************
-- *********************************
-- *********************************
--		  	 		  RULES
-- *********************************
-- *********************************
-- *********************************

-- Rules to apply to new clients.
-- @DOC_RULES@

-- Q: What is this?
-- A: Defines how applications windows are started (Tiled,Floating,etc...)

ruled.client.connect_signal("request::rules", function()
    -- @DOC_GLOBAL_RULE@
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

    -- @DOC_FLOATING_RULE@
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

    ruled.client.append_rule {
        rule = { class = "Nsxiv" },
        properties = {
            floating  = true,
            placement = awful.placement.centered,
            width     = 640,
            height    = 480,
        },
    }

    ruled.client.append_rule {
        rule = { class = "Xfce4-appfinder" },
        properties = {
            floating  = true,
            placement = awful.placement.up,
            width     = 640,
            height    = 40,
        },
    }

    ruled.client.append_rule {
        rule = { class = "Nm-connection-editor" },
        properties = {
            floating  = true,
            placement = awful.placement.centered,
            width     = 640,
            height    = 40,
        },
    }

    ruled.client.append_rule {
        rule = { class = "Code" },
        properties = {
            floating  = false,
            --placement = awful.placement.centered,
        },
    }


end)

-- *********************************
-- *********************************
-- *********************************
--		  	  TITLE BARS
-- *********************************
-- *********************************
-- *********************************

-- @DOC_TITLEBARS@
-- Add a titlebar if titlebars_enabled is set to true in the rules.

client.connect_signal("request::titlebars", function(c)
    -- Buttons for the titlebar (mouse actions)
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(c).widget = {
        -- Left
        { 
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Middle
        { 
            -- Title
            { 
                halign = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        -- Right
        { 
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- *********************************
-- *********************************
-- *********************************
--		  	  NOTIFICATIONS
-- *********************************
-- *********************************
-- *********************************

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- *********************************
-- *********************************
-- *********************************
--		  BOOT CONFIGURATION
-- *********************************
-- *********************************
-- *********************************

-- Enable VMware Guest Tools
awful.util.spawn_with_shell("vmware-user-suid-wrapper --no--startup-id")
-- Start Picom
awful.util.spawn_with_shell("killall picom; picom --config ~/.config/picom/picom.conf -b")
-- Start Wallpaper with reload enabled upon X11 events
awful.util.spawn_with_shell("killall xeventbind; xeventbind resolution ~/.fehbg")
awful.util.spawn_with_shell("killall feh; ~/.fehbg")
-- Start Polybar with reload enabled upon changes
awful.util.spawn_with_shell("polybar -r main")

-- *********************************
-- *********************************
-- *********************************
--		  				FOCUS
-- *********************************
-- *********************************
-- *********************************

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
