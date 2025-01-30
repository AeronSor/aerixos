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
    windowManager.awesome = { enable = true; };
  };

  # Specific X11 packages
  environment.systemPackages = with pkgs; [
    xclip
    flameshot
    emote
    xwinwrap
    xournalpp
    unclutter-xfixes
    lxappearance
    xorg.xmodmap
    picom-pijulius
    xorg.xev
    xorg.xinit
  ];
}
