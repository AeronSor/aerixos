{ config, lib, pkgs, ... }:

{
  # Enable Wayland protocol and hyprland
  programs.hyprland = {
    enable = lib.mkForce true;
    xwayland.enable = lib.mkForce true;
  }

  
  # Specific Wayland packages
  environment.systemPackages = with pkgs; 
  [
    swww
    wofi
    wofi-emoji
    eww
    wl-clipboard
    jq
    socat
    nwg-look
    gamescope
  ]
}
