#!/usr/bin/env bash

# ── Sinks ──────────────────────────────────────────────────────────────────────
declare -A SINKS=(
    ["🔊  Laptop speakers"]="alsa_output.pci-0000_03_00.6.HiFi__Speaker__sink"
    ["🖥️  HDMI"]="alsa_output.pci-0000_03_00.1.HiFi__HDMI1__sink"
    ["🎧  Bluetooth headphones"]="bluez_output.18_9C_2C_DD_03_3F.1"
)

# ── Show menu ──────────────────────────────────────────────────────────────────
CHOICE=$(printf '%s\n' "${!SINKS[@]}" | sort | rofi -dmenu \
    -p "🔊 Audio output" \
    -theme-str 'window {width: 380px;}' \
    -i)

[[ -z "$CHOICE" ]] && exit 0

# ── Apply sink ─────────────────────────────────────────────────────────────────
SINK="${SINKS[$CHOICE]}"
pactl set-default-sink "$SINK"

# Move all active streams to the new sink
pactl list short sink-inputs | awk '{print $1}' | while read -r INPUT; do
    pactl move-sink-input "$INPUT" "$SINK"
done

# ── Notify ─────────────────────────────────────────────────────────────────────
notify-send "Audio output" "$CHOICE" --icon=audio-headphones -t 2000
