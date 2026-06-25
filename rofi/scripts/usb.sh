#!/bin/bash

# Script to mount/unmount USB drives with Rofi and notifications
# Requirements: rofi, udisks2, libnotify

# Rofi theme configuration
# ROFI_THEME="-theme-str 'window {width: 500px;}'"

# Get list of removable devices
get_devices() {
    lsblk -nrp -o NAME,TYPE,MOUNTPOINT | awk '
        $2 == "part" {
            if ($3 == "") {
                # Unmounted device
                print $1 " (unmounted)"
            } else {
                # Mounted device
                print $1 " (mounted at " $3 ")"
            }
        }
    '
}

# Mount USB function
mount_usb() {
    local device=$1
    if udisksctl mount -b "$device" 2>/dev/null; then
        local mount_point=$(lsblk -nrp -o NAME,MOUNTPOINT | grep "^$device " | awk '{print $2}')
        notify-send "✓ USB Mounted" "Device: $device\nMounted at: $mount_point" -i drive-removable-media -u normal
    else
        notify-send "✗ Mount Failed" "Could not mount: $device" -i dialog-error -u critical
    fi
}

# Unmount USB function
unmount_usb() {
    local device=$1
    if udisksctl unmount -b "$device" 2>/dev/null; then
        notify-send "✓ USB Unmounted" "Device: $device" -i drive-removable-media -u normal
    else
        notify-send "✗ Unmount Failed" "Could not unmount: $device\n(Files in use?)" -i dialog-error -u critical
    fi
}

# Main menu
main_menu() {
    local devices=$(get_devices)
    
    if [ -z "$devices" ]; then
        notify-send "ℹ Information" "No devices detected" -i drive-removable-media
        return
    fi
    
    # Show menu with Rofi
    local selected=$(echo "$devices" | rofi -dmenu $ROFI_THEME -p "USB Manager: ")
    
    if [ -n "$selected" ]; then
        # Extract device name (e.g: /dev/sda1 from "/dev/sda1 (unmounted)")
        local device=$(echo "$selected" | awk '{print $1}')
        
        # Determine if mounted or unmounted
        if echo "$selected" | grep -q "(unmounted)"; then
            # Show mount option
            local action=$(echo -e "Mount\nCancel" | rofi -dmenu $ROFI_THEME -p "What do you want to do? ")
            if [ "$action" = "Mount" ]; then
                mount_usb "$device"
            fi
        else
            # Show unmount option
            local action=$(echo -e "Unmount\nCancel" | rofi -dmenu $ROFI_THEME -p "What do you want to do? ")
            if [ "$action" = "Unmount" ]; then
                unmount_usb "$device"
            fi
        fi
    fi
}

# Execute main menu
main_menu
