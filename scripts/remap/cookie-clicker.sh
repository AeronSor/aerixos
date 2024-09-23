#!/bin/bash

# Save the current keymap settings
xmodmap -pke > ~/.Xmodmap.backup

# Remap Numpad to act as arrows
xmodmap - <<EOF
keycode 83 = Pointer_Button1
keycode 80 = Pointer_Button1
keycode 85 = Pointer_Button1
keycode 88 = Pointer_Button1
EOF

# Wait for user input to restore original settings
read -p "Press Enter to restore original keymap..."

# Restore original keymap settings
xmodmap ~/.Xmodmap.backup

# Clean up backup file
rm ~/.Xmodmap.backup
