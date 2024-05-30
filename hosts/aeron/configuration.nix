# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
	imports =
	[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./main-user.nix
		inputs.home-manager.nixosModules.default
	];

	# Allow proprietary Software
	nixpkgs.config.allowUnfree = true;


	# Allow experimental features
	nix.settings.experimental-features = [ "nix-command" "flakes" ];


	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "aeron"; # Define your hostname.
	# Pick only one of the below networking options.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	networking.networkmanager = {
	enable = true;

	# Custom DNS
	insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
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

	# Enable touchpad support (enabled default in most desktopManager).
	services.libinput.enable = true;

	# Define a user account using a custom module. Don't forget to set a password with ‘passwd’.
	main-user.enable = true;
	main-user.userName = "aeron";

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
	# Base
	wget
	firefox
	kitty
	git
	python3
	lua
	go
	nodejs
	font-manager
	pavucontrol
	ranger
	xfce.thunar
	zoxide
	htop
	acpi
	imv
	mpv
	xclip
	unzip
	alsa-utils

	# Move below to home manager later

	# Electronics
	logisim-evolution

	# Art stuff
	obs-studio
	krita
	blender
	kdenlive

	# Misc apps
	vesktop
	obsidian
	neovim
	neovide
	flameshot
	mangohud
	protonup
	keepassxc
	vlc
	ark

	# Utils
	pciutils
	lshw
	glxinfo
	vulkan-tools
	nvtop
	lxappearance

	# Theming
	arc-icon-theme
	bibata-cursors
	];

	# Fonts
	fonts.packages = with pkgs; [
	terminus-nerdfont
	noto-fonts-cjk-serif 
	hackgen-nf-font
	];

	# Home manager
	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"aeron" = import ./home.nix;
		};
	};


	# Handle steam (temp location)
	programs.gamemode.enable = true;
	programs.steam = {
		enable = true;
		gamescopeSession.enable = true;
	};

	# Protonup path
	environment.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATHS =
			"/home/aeron/.steam/steam/compatibilitytools.d";
	};


	# Power management
	services.tlp = {
		enable = true;
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
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		open = false;
		nvidiaSettings = true;
		#modesetting.enable = true;
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
			system.nixos.tags = [ "on-the-go" ];
			hardware.nvidia = {
				prime.offload.enable = lib.mkForce true;
				prime.offload.enableOffloadCmd = lib.mkForce true;
				prime.sync.enable = lib.mkForce false;
			};
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

