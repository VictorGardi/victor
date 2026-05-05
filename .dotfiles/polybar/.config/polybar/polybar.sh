#!/usr/bin/env sh
#
# Terminate already running bar instances
killall -q polybar
#
## Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done
#
## Launch polybar
#nm-applet &
#polybar example 2>&1 | tee -a /tmp/polybar1.log & disown
#
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi
