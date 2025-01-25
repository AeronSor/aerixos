{ config, pkgs, ... }: 

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aeron";
  home.homeDirectory = "/home/aeron";

  #
  # You should not change this value, even if you update Home Manager. If you do
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Import modules
  imports = [
    ./packages-home.nix
    ./helix.nix
  ];

  # Git config
  programs.git = {
    enable = true;
    userName = "AeronSor";
    userEmail = "aeronsor@gmail.com";
  };

  # Neovim
  programs.neovim = {
    enable = true;
  };

  # Handle neovim packages with nixpkgs instead of mason or other plugin
  # Why? it makes more sense in a nixOS system and this way I can avoid
  # messing with my stock neovim config
  #plugins = with pkgs.vimPlugins; [
  #];
  #}

  home.file = {
    #Set the DPI
    ".Xresources" = {
      text = ''        Xft.dpi: 110 
        Xcursor.size: 24
        Xcursor.theme: Bibata-Modern-Ice'';
      executable = false;
    };
  };

  programs.bash = {
    enable = true;
    # Make the .bashrc import itself from the aerixos folder
    # Why did I put this if though...
    initExtra = ''
      if [ -f $HOME/.dotfiles-general/bash/.bashrc ];
      then
      	source ~/Repos/aerixos/dotfiles/bash/.bashrc
      fi
    '';
  };

  home.sessionVariables = {
  };

  # Cursor theming
  home.pointerCursor = {
    #x11.enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
