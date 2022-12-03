#!/bin/bash

pkill polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

outputs=$(xrandr --query | grep " connected" | cut -d" " -f1)
set -- $outputs
tray_output=$1

	for m in $outputs; do
			if [ $m == $1 ]
			then
					MONITOR1=$m polybar --reload i3wmthemer_bar -c ~/.config/polybar/config.ini &
			elif [ $m == $2 ]
			then
				tray_output=$m
					MONITOR2=$m polybar --reload sidebar-i3-right -c ~/.config/polybar/config.ini &
			else
					MONITOR1=$m polybar --reload i3rmthemer_bar -c ~/config/polybar/config.ini &
			fi
	done
	
	for m in $outputs; do
		export MONITOR1=$1
		export MONITOR2=$2
		export TRAY_POSITION=none
		if [[ $m == $tray_output ]]; then
			TRAY_POSITION=right
		fi
	done
