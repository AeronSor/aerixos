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

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Handle neovim packages with nixpkgs instead of mason or other plugin
  # Why? it makes more sense in a nixOS system and this way I can avoid
  # messing with my stock neovim config
  #plugins = with pkgs.vimPlugins; [
  #];
  #}

  home.packages = with pkgs; [
    # Base
    kitty
    font-manager
    pavucontrol
    htop
    acpi
    imv
    mpv
    brightnessctl
    helvum
    distrobox
    appimage-run
    lua
    go
    nodejs
    ranger
    zoxide
    python3

    # Rust
    cargo
    rustc

    # Theming
    arc-icon-theme
    bibata-cursors
    rose-pine-gtk-theme

    # Electronics
    logisim-evolution
    #quartus-prime-lite this takes AGES to install, I'm just gonna use this on windows for now on
    kicad
    ngspice
    arduino-ide
    fritzing

    gsettings-desktop-schemas
    processing

    # Audio production
    puredata
    supercollider
    vcv-rack
    cardinal
    renoise
    milkytracker
    carla
    #yabridge
    #yabridgectl

    # Misc apps
    # Workaround for vesktop
    (vesktop.override {withSystemVencord = false;})
    firefox
    obsidian
    neovide
    flameshot
    mangohud
    protonup
    keepassxc
    vlc
    ark
    filezilla
    qbittorrent
    sioyek
    calibre
    ffmpeg
    #glaxnimate
    neofetch
    mpd
    mpc-cli
    ncmpcpp
    emote
    #thonny
    xwinwrap

    # Wine stuff
    wineWowPackages.staging
    winetricks
    #wineasio

    syncthing
    stremio
    libreoffice
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
    lutris
    easyrpg-player
    foliate
    losslesscut-bin
    #zeal
    #nicotine-plus
    #gmic-qt
    xournalpp

    # Emulators
    pcsx2
    #mednafen
    #mednaffe
    duckstation
    #bsnes-hd

    # Games
    cataclysm-dda
    #gzdoom

    # Art stuff
    obs-studio
    krita
    gimp
    blender
    kdenlive
    audacity
    inkscape
    opentabletdriver
    godot_4

    # Utils
    unclutter-xfixes
    nvtopPackages.nvidia
    vulkan-tools
    alejandra
    lxappearance
    nix-tree
    yt-dlp
    gparted
    xorg.xmodmap
    slop
    maim
    picom-pijulius
    pciutils
    glxinfo
    pkgs.autoAddDriverRunpath
    xorg.xev
    xorg.xinit
    ventoy
    ncdu
    #epsonscan2

    # LSPs for Neovim
    rust-analyzer
    vimPlugins.clang_complete
    luajitPackages.lua-lsp
    gopls
    pyright
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

  # Cursor theming
  xsession.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
