#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Get network Interface
export DEFAULT_NETWORK_INTERFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n1)

polybar -c ~/.config/polybar/config.ini main &

external_monitor=$(xrandr --query | grep 'HDMI-0')
if [[ $external_monitor = HDMI-0\ connected* ]]; then
    polybar -c ~/.config/polybar/config.ini secondary &
fi

external_monitor=$(xrandr --query | grep 'DP-0')
if [[ $external_monitor = DP-0\ connected* ]]; then
    polybar -c ~/.config/polybar/config.ini third &
fi
