{ config, pkgs, ... }:

{
 home.packages = with pkgs; [
  # Base
  kitty
  font-manager
  pavucontrol
  myxer
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
  sublime

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
  (vesktop.override {withSystemVencord = false;})
  firefox
  obsidian
  neovide
  vscode
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
  kcc
  spotify

  # Theming
  pywal
  swww

  # Wine stuff
  wineWowPackages.staging
  winetricks
  #wineasio

  # Random
  syncthing
  stremio
  libreoffice
  lutris
  easyrpg-player
  foliate
  losslesscut-bin
  nicotine-plus
  xournalpp
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
  gamescope
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


}
