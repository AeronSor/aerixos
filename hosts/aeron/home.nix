{ config, pkgs, ... }:

{
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
		];

	# GTK
	#gtk = {
		#enable = true;
	# 	theme = {
	# 		name = "Catppuccin-Macchiato-Standard-Blue-Dark";
	# 		package = pkgs.libsForQt5.breeze-gtk;
	# 	};
	# 	iconTheme = {
	# 		name = "Papirus-Dark";
	# 		package = pkgs.catppuccin-papirus-folders.override {
	# 			flavor = "mocha";
	# 			accent = "lavender";
	# 		};
	# 	};
	# 	cursorTheme = {
	# 		name = "Catppuccin-Mocha-Light-Cursors";
	# 		package = pkgs.catppuccin-cursors.mochaLight;
	# 	};
	# 	gtk3 = {
	# 		extraConfig.gtk-applicatoin-prefer-dark-theme = true;
	# 	};
	#};
	
	
	# home.pointerCursor = {
	# 	gtk.enable = true;
	# 	name = "Catppuccin-Mocha-Dark-Cursors";
	# 	package = pkgs.catppuccin-cursors.macchiatoDark;
	# 	size = 16;
	# };
	
	# QT
	#qt = {
		#enable = true;
	# 	platformTheme.name = "qtct";
	# 	style.name = "kvantum";
	#};

	#Theming
	#home.catppuccin.flavor = "mocha";
	#home.catppuccin.enable = true;

	home.file = {
	# Set the DPI 
	".Xresources" = { text = '' Xft.dpi: 110 ''; executable = false; };
	};

	home.sessionVariables = {
	EDITOR = "nvim";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
