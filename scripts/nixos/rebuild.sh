#!/bin/sh

set -e	# If something fails stop process
pushd ~/Repos/aerixos/	# Change directory and save the earlier one to the stack

# Editing
ranger

# Checking code with alejandra formatter
alejandra . &>/dev/null

# Showing changes
git diff -U0 hosts/aeron/*.nix
echo "NixOS Rebuilding..."

# Actual rebuild
# Kinda hacky because of home-manager being bugged with unfree software
sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --impure --flake ~/Repos/aerixos/#aeron

# Nice output
echo "Successfully built"
gen=$(nixos-rebuild list-generations | grep current)
git commit -am "$gen"
printf "Current Generation: $gen"
popd	# Return to said directory
