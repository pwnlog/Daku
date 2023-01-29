#!/usr/bin/bash

dir="$HOME/.config/polybar"

launch_bar(){
	killall -q polybar
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    
    # bspwm
    bspc config top_padding 0 2>/dev/null
    bspc config bottom_padding 0 2>/dev/null

    polybar -r -q main -c "$dir/$theme/config.ini" & 2>/dev/null
}

if [[ "$1" == "--daku" ]]; then
    theme="daku"
    launch_bar
elif [[ "$1" == "--dakura" ]]; then
    theme="dakura"
    launch_bar
else
    cat <<- EOF
Usage: polybar.sh --theme
Available Themes:
    --daku
    --dakura
EOF
fi
