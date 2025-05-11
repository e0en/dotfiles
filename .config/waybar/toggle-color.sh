#!/usr/bin/env bash
CUR=$(gsettings get org.gnome.desktop.interface color-scheme)
if [[ $CUR == "'prefer-dark'" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
fi
pkill waybar
waybar &
disown
