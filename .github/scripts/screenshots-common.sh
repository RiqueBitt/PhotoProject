#!/usr/bin/env bash
# Base comum: tela virtual 1600x1000 com openbox, funções de captura e entrada.
set -u
APP="$(readlink -f "$1")"
OUT="$(mkdir -p "$2" && readlink -f "$2")"
chmod +x "$APP" 2>/dev/null
export DISPLAY=:99 APPIMAGE_EXTRACT_AND_RUN=1 NO_AT_BRIDGE=1 LIBGL_ALWAYS_SOFTWARE=1 QT_DEBUG_PLUGINS=${QT_DEBUG_PLUGINS:-0}
Xvfb :99 -screen 0 1600x1000x24 -nolisten tcp >/dev/null 2>&1 &
sleep 2
(command -v openbox >/dev/null && openbox >/dev/null 2>&1 &)
sleep 1
n=0
shot() { n=$((n+1)); sleep "${2:-2}"; import -window root "$(printf '%s/%02d-%s.png' "$OUT" "$n" "$1")"; echo "captura $n: $1"; }
key() { timeout 10 xdotool key --clearmodifiers "$@"; }
typ() { timeout 20 xdotool type --delay 40 "$1"; }
click() { timeout 10 xdotool mousemove "$1" "$2" click 1; }
dclick() { timeout 10 xdotool mousemove "$1" "$2" click --repeat 2 1; }
drag() { timeout 10 xdotool mousemove "$1" "$2" mousedown 1; for i in $(seq 1 20); do timeout 5 xdotool mousemove $(( $1 + ($3-$1)*i/20 )) $(( $2 + ($4-$2)*i/20 )); sleep 0.03; done; timeout 5 xdotool mouseup 1; }
maximize() { local W; W=$(timeout 10 xdotool search --onlyvisible --name "$1" 2>/dev/null | tail -1); [ -n "$W" ] && timeout 10 xdotool windowfocus "$W" windowsize "$W" 1600 1000 windowmove "$W" 0 0; xdotool search --onlyvisible --name "" getwindowname %@ 2>/dev/null | head -20; }
finish() { kill ${APP_PID:-0} 2>/dev/null; sleep 1; pkill openbox 2>/dev/null; pkill -f "Xvfb :99" 2>/dev/null; ls -la "$OUT"; true; }
