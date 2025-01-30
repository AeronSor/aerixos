{ config, pkgs, ... }:

{
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
    raysession
    distrobox
    appimage-run
    lua
    go
    nodejs
    ranger
    zoxide
    python3
    xdotool

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
    #processing

    # Audio production
    puredata
    supercollider
    vcv-rack
    cardinal
    renoise
    milkytracker
    carla
    plugdata
    #yabridge
    #yabridgectl

    # Misc apps
    # Workaround for vesktop
    (vesktop.override { withSystemVencord = false; })
    firefox
    obsidian
    neovide
    vscode
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
    neofetch
    mpd
    mpc-cli
    ncmpcpp
    #thonny
    xwinwrap
    spotify
    element # This is so fucking cool
    element-desktop

    # Theming
    pywal

    # Wine stuff
    wineWowPackages.staging
    winetricks
    #wineasio

    # Random
    syncthing
    stremio
    libreoffice
    lutris
    losslesscut-bin
    nicotine-plus
    #gmic-qt
    #zeal

    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US

    # Emulators
    pcsx2
    #mednafen
    #mednaffe
    duckstation
    #bsnes-hd

    # Games
    cataclysm-dda
    prismlauncher
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
    nvtopPackages.nvidia
    vulkan-tools
    alejandra
    nix-tree
    yt-dlp
    gparted
    slop
    maim
    pciutils
    glxinfo
    pkgs.autoAddDriverRunpath
    ventoy
    ncdu
    arrpc

    # LSPs for Neovim
    rust-analyzer
    vimPlugins.clang_complete
    luajitPackages.lua-lsp
    gopls
    pyright

    # Printing
    epson-escpr
    epsonscan2
  ];

}
