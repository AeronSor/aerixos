## Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# Test
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./main-user.nix
    inputs.home-manager.nixosModules.default
  ];

  # Allow proprietary Software
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
    allowUnfreePredicate = pkg: true;
  };

  # Allow flatpak
  services.flatpak.enable = true;

  # Allow experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Disable systemd-boot loader and setup GRUB
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable auto upgrading
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # Print Build logs
    ];
    dates = "Friday 20:00";
    randomizedDelaySec = "20min";
  };

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "Saturday 10:00";
    randomizedDelaySec = "20m";
  };

  # Enable automatic storage optimization
  nix.optimise = {
    automatic = true;
    dates = ["Saturday 12:00"];
  };

  # Use GRUB
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  networking.hostName = "aeron"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager = {
    enable = true;

    # Custom DNS
    insertNameservers = ["1.1.1.1" "1.0.0.1"];
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # X11 Keymap
    xkb.layout = "br";

    # Display manager
    displayManager.lightdm.enable = true;

    # Window manager
    windowManager.awesome = {
      enable = true;
    };
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable XDG Desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = "*";

  # Pipewire Sound config
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account using a custom module. Don't forget to set a password with ‘passwd’.
  main-user.enable = true;
  main-user.userName = "aeron";

  # Enable docker
  virtualisation.docker.enable = true;

  # Enable random executables to run
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add missing dynamic libraries for unpacked programs here
  ];

  # Enable FHS spoofing
  services.envfs.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Base
    wget
    firefox
    kitty
    git
    lua
    go
    nodejs
    font-manager
    pavucontrol
    ranger
    zoxide
    htop
    acpi
    imv
    mpv
    xclip
    unzip
    alsa-utils
    networkmanagerapplet
    brightnessctl
    dunst
    gvfs
    mtpfs
    jmtpfs
    wireplumber
    helvum
    gcc # C stuff
    fuse
    ntfs3g
    distrobox
    easyrpg-player

    # Theming
    arc-icon-theme
    bibata-cursors

    # Electronics
    logisim-evolution

    # Audio production
    puredata
    supercollider

    # Art stuff
    obs-studio
    krita
    gimp
    blender
    kdenlive
    audacity
    inkscape
    opentabletdriver

    # Misc apps

    # Workaround for vesktop
    (vesktop.override {withSystemVencord = false;})
    obsidian
    neovim
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
    ollama
    calibre
    ffmpeg
    glaxnimate
    bsnes-hd
    neofetch
    mpd
    mpc-cli
    ncmpcpp
    emote
    thonny
    xwinwrap
    wineWowPackages.stable
    syncthing
    stremio
    libreoffice
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US
    bottles
    lutris

    # Emulators
    pcsx2
    mednafen
    mednaffe

    # Utils
    pciutils
    unclutter-xfixes
    lshw
    glxinfo
    vulkan-tools
    nvtopPackages.nvidia
    cudaPackages.autoAddDriverRunpath
    lxappearance
    alejandra
    xorg.xev
    xorg.xinit
    ventoy
    gparted
    nix-tree
    yt-dlp
    bcc

    # Project dependencies
    # Python stuff
    python3
  ];

  # Fonts
  fonts.packages = with pkgs; [
    terminus-nerdfont
    nerdfonts
    noto-fonts-cjk-serif
    hackgen-nf-font
    ipafont
    kochi-substitute
    source-code-pro
    dejavu_fonts
  ];

  # Default fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
      "IPAGothic"
    ];
    sansSerif = [
      "DejaVu Sans"
      "IPAGothic"
    ];
    serif = [
      "DejaVu Serif"
      "IPAPMincho"
    ];
  };

  # IME enalbing
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  # Set up thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    gvfs
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.tumbler
  ];

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "aeron" = import ./home.nix;
    };
  };

  # Opentablerdriver
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  # Handle steam (temp location)
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  # Protonup path
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/aeron/.steam/steam/compatibilitytools.d";
  };

  # Power management (Kinda bugged atm)
  services.tlp = {
    enable = false;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Charge trehsholds
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVIDIA (default offload mode)
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = false;
    nvidiaSettings = false;
    #modesetting.enable = true;
  };

  hardware.nvidia.package = let
  in
    config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "535.154.05";
      sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/Woc0qFFbZVBh+ToGhaE=";
      patches = [];
    };

  hardware.nvidia.prime = {
    sync.enable = true;
    offload = {
      enable = false;
      enableOffloadCmd = false;
    };

    # Bus ID of NVIDIA GPU,use lspi
    nvidiaBusId = "PCI:1:0:0";

    # Bus ID of Intel GPU, use lspci
    intelBusId = "PCI:0:2:0";
  };

  # Specialisation for Graphics
  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
        prime.sync.enable = lib.mkForce false;
      };

      # Completely turning off DGPU
      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';

      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
      boot.blacklistedKernelModules = ["nouveau" "nvidia" "nvidia_drm" "nvidia_modeset"];
    };
  };

  # Blacklist kernel modules
  boot.blacklistedKernelModules = ["nouveau"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
