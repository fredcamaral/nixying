#!/usr/bin/env bash

echo "Attempting to stop any running instance of waybar..."
pkill waybar

sleep 1

if pgrep waybar >/dev/null 2>&1; then
	echo "Failed to stop waybar." >&2
else
	echo "Waybar stopped successfully."
	echo "Starting waybar..."
	waybar &>/dev/null &
	disown
	echo "Waybar restarted successfully."
fi