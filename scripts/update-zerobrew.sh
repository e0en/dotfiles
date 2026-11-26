#!/bin/bash
set -eu

binary="${ZEROBREW_BIN:-$HOME/.local/bin}/zb"
if [[ -x "$binary" ]]; then
    release=$(curl -fsSIL -o /dev/null -w '%{url_effective}' https://github.com/zerobrewhq/zerobrew/releases/latest)
    if [[ "$("$binary" --version)" == "zb ${release##*/v}" ]]; then
        exit 0
    fi
fi

installer=$(mktemp)
trap 'rm -f "$installer"' EXIT
curl -fsSL https://zerobrew.rs/install -o "$installer"
/bin/bash "$installer" --no-modify-path
