{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Display manager
    displayManager.lightdm = {
      enable = true;
      greeters.slick.enable = true;
      greeters.slick.theme.name = "rose-pine-gtk";
    };

    # X11 Keymap
    xkb.layout = "br";

    #Window manager
    windowManager.awesome = {
      enable = true;
    };
  };
}
