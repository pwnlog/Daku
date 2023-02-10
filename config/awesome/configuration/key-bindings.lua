local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local naughty = require("naughty")
local bling = require("modules.bling")
local helpers = require("helpers")


-- *********************************
-- *********************************
-- *********************************
--		         KEYS
-- *********************************
-- *********************************
-- *********************************

modkey = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"

-- *********************************
-- *********************************
-- *********************************
--		  GLOBAL KEY BINDINGS
-- *********************************
-- *********************************
-- *********************************

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    -- *********************************
    -- *********************************
    -- *********************************
    --		  WM KEY BINDINGS
    -- *********************************
    -- *********************************
    -- *********************************

    -- Show Keyboard Shortcuts Help
    awful.key(
        { modkey },
        "s",
        hotkeys_popup.show_help,
        {description="show help/display shortcuts", group="WM"}
    ),
    
    -- Show AwesomeWM menu
    --[[
    awful.key(
        { modkey },
        "c",
        function () 
            mymainmenu:show() 
        end,
        {description = "show main menu", group = "awesome"}
    ),
    --]]
    
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
    
    -- *********************************
    -- *********************************
    -- *********************************
    --		  APP KEY BINDINGS
    -- *********************************
    -- *********************************
    -- *********************************

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
    awful.key(
        { modkey },
        "x",
        function ()
            awful.prompt.run {
            prompt       = "Run Lua code: ",
            textbox      = awful.mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}
	),
    --]]


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

-- *********************************
-- *********************************
-- *********************************
--	  CUSTOM SCRIPTS KEY BINDINGS
-- *********************************
-- *********************************
-- *********************************

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

-- *********************************
-- *********************************
-- *********************************
--        WORKSPACES KEY ARROWS
-- *********************************
-- *********************************
-- *********************************

--[[
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
--]]

-- *********************************
-- *********************************
-- *********************************
--		  FOCUS KEY BINDINGS
-- *********************************
-- *********************************
-- *********************************

awful.keyboard.append_global_keybindings({
	--- Focus client with keys
	awful.key(
        { modkey },
        "k",
        function()
		    awful.client.focus.bydirection("up")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus up window", group = "client" }
    ),

	awful.key(
        { modkey },
        "j",
        function()
		    awful.client.focus.bydirection("down")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus down window", group = "client" }
    ),
	
    awful.key(
        { modkey },
        "h",
        function()
		    awful.client.focus.bydirection("left")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus left window", group = "client" }
    ),
	
    awful.key(
        { modkey },
        "l",
        function()
		    awful.client.focus.bydirection("right")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus right window", group = "client" }
    ),

    -- Focus client with arrow keys
	awful.key(
        { modkey },
        "Up",
        function()
		    awful.client.focus.bydirection("up")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus up window", group = "client" }
    ),
	
    awful.key(
        { modkey },
        "Down",
        function()
		    awful.client.focus.bydirection("down")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus down window", group = "client" }
    ),
	
    awful.key(
        { modkey },
        "Left",
        function()
		    awful.client.focus.bydirection("left")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus left window", group = "client" }
    ),
	
    awful.key(
        { modkey },
        "Right",
        function()
		    awful.client.focus.bydirection("right")
		    bling.module.flash_focus.flashfocus(client.focus)
	    end,
        { description = "focus right window", group = "client" }
    ),

	--- Resize focused client with keys
	awful.key(
        { modkey, ctrl },
        "k",
        function(w)
		    helpers.window.resize_window(client.focus, "up")
	    end,
        { description = "window resize to the up", group = "client" }
    ),

	awful.key(
        { modkey, ctrl },
        "j",
        function(w)
		    helpers.window.resize_window(client.focus, "down")
	    end,
        { description = "window resize to the down", group = "client" }
    ),
	
    awful.key(
        { modkey, ctrl },
        "h",
        function(w)
		    helpers.window.resize_window(client.focus, "left")
	    end,
        { description = "window resize to the left", group = "client" }
    ),
	
    awful.key(
        { modkey, ctrl },
        "l",
        function(w)
		    helpers.window.resize_window(client.focus, "right")
	    end,
        { description = "window resize to the right", group = "client" }
    ),
    
    -- Resize focused client with arrow keys
	awful.key(
        { modkey, ctrl },
        "Up",
        function(w)
		    helpers.window.resize_window(client.focus, "up")
	    end,
        { description = "window resize to the up", group = "client" }
    ),
	
    awful.key(
        { modkey, ctrl },
        "Down",
        function(w)
		    helpers.window.resize_window(client.focus, "down")
	    end,
        { description = "window resize to the down", group = "client" }
    ),
	
    awful.key(
        { modkey, ctrl },
        "Left",
        function(w)
		    helpers.window.resize_window(client.focus, "left")
	    end,
        { description = "window resize to the left", group = "client" }
    ),
	
    awful.key(
        { modkey, ctrl },
        "Right",
        function(w)
		    helpers.window.resize_window(client.focus, "right")
	    end,
        { description = "window resize to the right", group = "client" }
    )

})

-- *********************************
-- *********************************
-- *********************************
--		  LAYOUT KEY BINDINGS
-- *********************************
-- *********************************
-- *********************************

awful.keyboard.append_global_keybindings({
	--- Set tilling layout
	awful.key({ modkey, shift }, "t", function()
		awful.layout.set(awful.layout.suit.tile)
	end, { description = "set tile layout", group = "layout" }),

	--- Set floating layout
	awful.key({ modkey, shift }, "s", function()
		awful.layout.set(awful.layout.suit.floating)
	end, { description = "set floating layout", group = "layout" }),

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
    
    --[[
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
    --]]
    
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
    --]]
    
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

-- *********************************
-- *********************************
-- *********************************
--		  WORKSPACES KEY BINDINGS
-- *********************************
-- *********************************
-- *********************************

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

-- *********************************
-- *********************************
-- *********************************
--		  CLIENT KEY BINDINGS
-- *********************************
-- *********************************
-- *********************************

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		--- Move client by DPI
		awful.key(
            { modkey, shift, ctrl },
            "j",
            function(c)
			    c:relative_move(0, dpi(20), 0, 0)
		    end,
            { description = "move client by dpi", group = "client" }
        ),

		awful.key(
            { modkey, shift, ctrl },
            "k",
            function(c)
			    c:relative_move(0, dpi(-20), 0, 0)
		    end,
            { description = "move client by dpi", group = "client" }
        ),

		awful.key(
            { modkey, shift, ctrl },
            "h",
            function(c)
			    c:relative_move(dpi(-20), 0, 0, 0)
		    end,
            { description = "move client by dpi", group = "client" }
        ),

		awful.key(
            { modkey, shift, ctrl },
            "l",
            function(c)
			    c:relative_move(dpi(20), 0, 0, 0)
		    end,
            { description = "move client by dpi", group = "client" }
        ),

		--- Toggle fullscreen
		awful.key(
            { modkey },
            "f",
            function()
                client.focus.fullscreen = not client.focus.fullscreen
                client.focus:raise()
		    end,
            { description = "toggle full screen", group = "client" }
        ),

		--- Maximize windows
		awful.key(
            { modkey },
            "m",
            function(c)
                c.maximized = not c.maximized
		    end, 
            { description = "toggle maximize", group = "client" }
        ),
		
        awful.key(
            { modkey, ctrl },
            "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
		    end, 
            { description = "(un)maximize vertically", group = "client" }
        ),
		
        awful.key(
            { modkey, shift },
            "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
		    end,
            { description = "(un)maximize horizontally", group = "client" }
        ),

		--- Minimize windows
		awful.key(
            { modkey },
            "n",
            function(c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
		    end,
            { description = "minimize", group = "client" }
        ),

		--- Un-minimize windows
        awful.key({ modkey, ctrl }, "n",
        function ()
            naughty.notify({text="trying un-minimize window"})
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal(
                  "request::activate", "key.unminimize", {raise = true}
              )
            end
        end,
        {description = "restore minimized", group = "client"}),

		--- Keep on top
		awful.key(
            { modkey },
            "p",
            function(c)
			    c.ontop = not c.ontop
		    end,
            { description = "keep client/window on top", group = "client" }
        ),

		--- Sticky
		awful.key(
            { modkey, shift },
            "p",
            function(c)
			    c.sticky = not c.sticky
		    end,
            { description = "sticky client/window", group = "client" }
        ),

		--- Close window
		awful.key(
            { modkey },
            "w",
            function()
			    client.focus:kill()
		    end,
            { description = "close client/window", group = "client" }
        ),

		--- Center window
		awful.key(
            { modkey },
            "c",
            function()
			    awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
		    end,
            { description = "center client/window", group = "client" }
        ),
	})
end)
