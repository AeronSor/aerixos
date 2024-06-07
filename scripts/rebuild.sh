#!/bin/sh

set -e	# If something fails stop process
pushd ~/Repos/aerixos/	# Change directory and save the earlier one to the stack
ranger
alejandra . &>/dev/null	# Use a nix code formatter
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild --flake ~/Repos/aerixos/#aeron &>nixos-switch.log || (cat nixos-switch.log | grep --collor error && false)
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
popd	# Return to said directory


