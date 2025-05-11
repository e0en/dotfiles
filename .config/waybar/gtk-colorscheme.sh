#!/usr/bin/env bash
CUR=$(gsettings get org.gnome.desktop.interface color-scheme)
if [[ $CUR == "'prefer-dark'" ]]; then
    # print moon emoji
    echo "🌙"
else
    # print sun emoji
    echo "☀️"
fi
