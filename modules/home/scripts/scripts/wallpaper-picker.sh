#!/usr/bin/env bash

wallpaper_path=$HOME/repos/nixying/wallpapers
wallpapers_folder=$HOME/repos/nixying/wallpapers
wallpaper_name="$(ls $wallpapers_folder | rofi -dmenu || pkill rofi)"
if [[ -f $wallpapers_folder/$wallpaper_name ]]; then
    find ~/repos/nixying/wallpapers -maxdepth 1 -type f -delete
    cp $wallpapers_folder/$wallpaper_name $wallpaper_path/$wallpaper_name
    wall-change $wallpaper_path/$wallpaper_name
else
    exit 1
fi
