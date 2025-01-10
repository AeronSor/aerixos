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

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "aeron" = import ../home-manager/home.nix;
    };
  };

  # --- Flakes --- #

  # Musnix
  musnix = {
    enable = true;
    rtcqs.enable = true;
    soundcardPciId = "0000:00:1f.3";
  };

  # Overlays
  nixpkgs.overlays = [
    # For my nvim config
    #<aeronvim-nix>.overlays.default
  ];

  # Allow proprietary Software
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
    allowUnfreePredicate = pkg: true;
  };

  # Allow flatpak
  services.flatpak.enable = true;

  # Allow Appimages to be ran with appimage-run by default
  programs.appimage.binfmt = true;

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
    options = "--delete-older-than 30d";
  };

  # Enable automatic storage optimization
  nix.optimise = {
    automatic = true;
  };

  # Use GRUB
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };

  # Enable printing
  services.printing.enable = true;
  services.printing.cups-pdf.enable = true;

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

  # Remove mouse acceleration
  services.libinput.mouse.accelProfile = "flat";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable XDG Desktop portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = "*";

  # Enable xdg mime and set defaults
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "Thunar.desktop";
    };

    addedAssociations = {
      "application/pdf" = "firefox.desktop";
      "text/xml" = [
        "neovide.desktop"
      ];
    };
  };


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
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    powerOnBoot = true;
    #input.General.ClassicBondedOnly = false;
  };
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
    #Add missing dynamic libraries for unpacked programs here
    # Probably better to make a shell, but I can't make it work
    # So I'll just do it this way instead.
    glib
    xorg.libX11
    xorg.libxcb
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    nss
    nspr
    at-spi2-atk
    dbus
    gdk-pixbuf
    gtk3
    pango
    cairo
    xorg.libXrandr
    expat
    libdrm
    mesa
    xorg.libXScrnSaver
    alsa-lib
    cups
  ];

  # Enable FHS spoofing
  services.envfs.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; let
    RStudio-with-my-packages = rstudioWrapper.override {
      packages = with rPackages; [
        dplyr
        tidyr
        stringr
        lubridate
        httr
        ggvis
        ggplot2
        shiny
        rio
        rmarkdown
        tidyverse
        EnvStats
      ];
    };
  in [
    #Overrides
    RStudio-with-my-packages

    # Base
    wget
    git
    xclip
    alsa-utils
    networkmanagerapplet
    dunst
    mtpfs
    jmtpfs
    wireplumber
    gcc
    fuse
    ntfs3g
    lxqt.lxqt-policykit

    # Utils
    lshw
    bcc
    p7zip
    zip
    unzip
    unrar

    # Hyprland stuff
    #hyprpaper
    #wofi
    #wofi-emoji
    #eww
    #wl-clipboard
    #jq
    #socat
    #nwg-look
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
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-configtool
    ];
  };

  # Environment Variables
  environment.variables.VLC_PLUGIN_PATH = "${pkgs.vlc-bittorrent}";

  # Set up thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    xfce.exo
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.tumbler
  ];

  # Enable gvfs
  services.gvfs.enable = true;

  # Enable polkit
  security.polkit.enable = true;

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
  hardware.graphics.enable = true;

  # NVIDIA (default offload mode)
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = false;
    nvidiaSettings = false;

    # required for wayland
    modesetting.enable = false;
  };

  hardware.nvidia.package = let
  in
    config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "560.35.03";
      sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
      sha256_aarch64 = "sha256-s8ZAVKvRNXpjxRYqM3E5oss5FdqW+tv1qQC2pDjfG+s=";
      openSha256 = "sha256-/32Zf0dKrofTmPZ3Ratw4vDM7B+OgpC4p7s+RHUjCrg=";
      settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
      persistencedSha256 = "sha256-E2J2wYYyRu7Kc3MMZz/8ZIemcZg68rkzvqEwFAL3fFs=";
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

  # Enable Sysrq
  boot.kernel.sysctl."kernel.sysrq" = 1;
  boot.kernel.sysctl."fs.file-max" = 524288;

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

  # SystemD

  # --- Services --- #

  # New year service
  systemd.services."new-year" = {
    description = "Runs a script on new year :)";
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash /home/aeron/Repos/aerixos/scripts/holidays/new-year.sh";

    serviceConfig.User = "aeron";
    serviceConfig.Restart = "no";

    serviceConfig.Environment = [
      "DISPLAY=:0" # Specifying display
      "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus" # Specify the DBus session path
    ];
  };

  # Eye break service
  systemd.services."eye-break" = {
    description = "Eye break notifcation";
    # Path of script
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash /home/aeron/Repos/aerixos/scripts/reminders/eye-break.sh";

    serviceConfig.User = "aeron";
    serviceConfig.Restart = "no";

    # Adding dunst to enviroment and setting up other stuff
    serviceConfig.Environment = [
      "DISPLAY=:0" # Specifying display
      "PATH=${pkgs.dunst}/bin:${pkgs.bash}/bin:/run/current-system/sw/bin:$PATH"
      "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus" # Specify the DBus session path
    ];
  };

  # Water break service
  systemd.services."water-break" = {
    description = "Water break notifcation";
    # Path of script
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash /home/aeron/Repos/aerixos/scripts/reminders/water-break.sh";

    serviceConfig.User = "aeron";
    serviceConfig.Restart = "no";

    # Adding dunst to enviroment and setting up other stuff
    serviceConfig.Environment = [
      "DISPLAY=:0" # Specifying display
      "PATH=${pkgs.dunst}/bin:${pkgs.bash}/bin:/run/current-system/sw/bin:$PATH"
      "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus" # Specify the DBus session path
    ];
  };

  # Stretch break service
  systemd.services."stretch-break" = {
    description = "Eye break notifcation";
    # Path of script
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash /home/aeron/Repos/aerixos/scripts/reminders/stretch-break.sh";

    serviceConfig.User = "aeron";
    serviceConfig.Restart = "no";

    # Adding dunst to enviroment and setting up other stuff
    serviceConfig.Environment = [
      "DISPLAY=:0" # Specifying display
      "PATH=${pkgs.dunst}/bin:${pkgs.bash}/bin:/run/current-system/sw/bin:$PATH"
      "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus" # Specify the DBus session path
    ];
  };

  # --- Timers --- #

  # New year timer
  systemd.timers."new-year-timer" = {
    description = "Runs every new year :)";
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*-01-01 00:00:00";
      Unit = "new-year.service";
    };
  };

  # 15 break timer
  systemd.timers."break-30-timer" = {
    description = "Run every 30 minutes";
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*:0/30";
      Unit = "eye-break.service";
    };
  };

  systemd.timers."break-35-timer" = {
    description = "Run every 35 minutes";
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*:0/35";
      Unit = "water-break.service";
    };
  };

  systemd.timers."break-1h-timer" = {
    description = "Run every 1 hour";
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "*-*-* *:00:00";
      Unit = "stretch-break.service";
    };
  };

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
