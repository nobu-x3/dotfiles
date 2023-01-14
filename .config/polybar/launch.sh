#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
killall -q glava
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
set -- $outputs
tray_output=$1

for m in $outputs; do

    if [ $m == $1 ]
    then
        MONITOR1=$m polybar -c $HOME/.config/polybar/dark-config nord-top &
        MONITOR1=$m polybar -c $HOME/.config/polybar/dark-config nord-down &
        glava --desktop &
    elif [ $m == $2 ]
    then
        MONITOR2=$m polybar -c $HOME/.config/polybar/dark-config nord-top-right-screen &
        MONITOR2=$m polybar -c $HOME/.config/polybar/dark-config nord-down-right-screen &
        glava --desktop &
    else
        MONITOR1=$m polybar -c $HOME/.config/polybar/dark-config nord-top &
        MONITOR1=$m polybar -c $HOME/.config/polybar/dark-config nord-down &
        glava --desktop &

    fi
done

for m in $outputs; do
    export MONITOR1=$1
    export MONITOR2=$2
done
# Launch bar1 and bar2
# if [ "$1" == "light" ]
# then
# 	polybar -c $HOME/.config/polybar/light-config nord-top &
# 	polybar -c $HOME/.config/polybar/light-config nord-down &
# 	glava --desktop &
# else
# 	polybar -c $HOME/.config/polybar/dark-config nord-top &
# 	polybar -c $HOME/.config/polybar/dark-config nord-down &
#   glava --desktop &
# fi

echo "Bars launched..."
