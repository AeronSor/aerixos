#!/bin/bash

# Save the current keymap settings
xmodmap -pke > ~/.Xmodmap.backup

# Remap Numpad to act as arrows
xmodmap - <<EOF
keycode 83 = Left
keycode 80 = Up
keycode 85 = Right
keycode 88 = Down
EOF

# Wait for user input to restore original settings
read -p "Press Enter to restore original keymap..."

# Restore original keymap settings
xmodmap ~/.Xmodmap.backup

# Clean up backup file
rm ~/.Xmodmap.backup
