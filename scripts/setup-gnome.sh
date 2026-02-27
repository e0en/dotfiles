#!/bin/bash

if ! command -v gsettings >/dev/null 2>&1; then
    exit 0
fi

gsettings set org.gnome.nautilus.preferences default-sort-order 'type'
gsettings set org.gnome.nautilus.preferences default-sort-in-reverse-order false
