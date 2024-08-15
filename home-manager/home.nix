{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aeron";
  home.homeDirectory = "/home/aeron";

  #
  # You should not change this value, even if you update Home Manager. If you do
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Git config
  programs.git = {
    enable = true;
    userName = "AeronSor";
    userEmail = "aeronsor@gmail.com";
  };

  home.packages = with pkgs; [
    # Art stuff
    obs-studio
    krita
    gimp
    blender
    kdenlive
    audacity
    inkscape
    opentabletdriver
  ];

  home.file = {
    # Set the DPI
    ".Xresources" = {
      text = ''Xft.dpi: 110 '';
      executable = false;
    };
  };

  programs.bash = {
    enable = true;
    # Make the .bashrc import itself from the aerixos folder
    initExtra = ''
      if [ -f $HOME/.dotfiles-general/bash/.bashrc ];
      then
      	source ~/Repos/aerixos/dotfiles/bash/.bashrc
      fi
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
