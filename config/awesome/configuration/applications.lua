local menubar = require "menubar"

terminal = "kitty"
file_manager = "thunar"
browser = "firefox"
launcher = "rofi -show drun"
editor = os.getenv("EDITOR") or "nvim"
ui_editor = "code"
editor_cmd = terminal .. " -e " .. editor

menubar.utils.terminal = terminal