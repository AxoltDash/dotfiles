#!/usr/bin/env bash

MONITORS_CONF="$HOME/.config/hypr/mod/monitors.conf"

# ── Menu options ───────────────────────────────────────────────────────────────
OPTIONS=(
    "🖥️  HDMI extended    1620p"
    "🪞  HDMI mirror      1620p"
    "🖥️  HDMI extended    1920p@100"
    "🪞  HDMI mirror      1920p@100"
)

CHOICE=$(printf '%s\n' "${OPTIONS[@]}" | rofi -dmenu \
    -p "🖥 Monitor" \
    -theme-str 'window {width: 420px;}' \
    -i)

[[ -z "$CHOICE" ]] && exit 0

# ── Config blocks ──────────────────────────────────────────────────────────────
HEADER="# =-- Monitors --= #"

SOLO_LAPTOP='monitor = eDP-1, 1920x1080@60, 0x0, 1'

HDMI_1620_EXT='monitor = HDMI-A-1, 1620x1080, auto, 1'
HDMI_1620_MIR='monitor = HDMI-A-1, 1620x1080, auto, 1, mirror, eDP-1'
HDMI_1920_EXT='monitor = HDMI-A-1, 1920x1080@100, auto, 1'
HDMI_1920_MIR='monitor = HDMI-A-1, 1920x1080@100, auto, 1, mirror, eDP-1'

# ── Write based on choice ──────────────────────────────────────────────────────
case "$CHOICE" in
    "${OPTIONS[0]}")   # HDMI extended 1620p
        cat > "$MONITORS_CONF" <<EOF
$HEADER
$SOLO_LAPTOP
# - 1620px - #
$HDMI_1620_EXT
# $HDMI_1620_MIR
# - 1920px - #
# $HDMI_1920_EXT
# $HDMI_1920_MIR
EOF
        ;;

    "${OPTIONS[1]}")   # HDMI mirror 1620p
        cat > "$MONITORS_CONF" <<EOF
$HEADER
$SOLO_LAPTOP
# - 1620px - #
# $HDMI_1620_EXT
$HDMI_1620_MIR
# - 1920px - #
# $HDMI_1920_EXT
# $HDMI_1920_MIR
EOF
        ;;

    "${OPTIONS[2]}")   # HDMI extended 1920p
        cat > "$MONITORS_CONF" <<EOF
$HEADER
$SOLO_LAPTOP
# - 1620px - #
# $HDMI_1620_EXT
# $HDMI_1620_MIR
# - 1920px - #
$HDMI_1920_EXT
# $HDMI_1920_MIR
EOF
        ;;

    "${OPTIONS[3]}")   # HDMI mirror 1920p
        cat > "$MONITORS_CONF" <<EOF
$HEADER
$SOLO_LAPTOP
# - 1620px - #
# $HDMI_1620_EXT
# $HDMI_1620_MIR
# - 1920px - #
# $HDMI_1920_EXT
$HDMI_1920_MIR
EOF
        ;;
esac

# ── Reload Hyprland ────────────────────────────────────────────────────────────
hyprctl reload

# Restart hyprpaper and waybar
pkill waybar && waybar &
