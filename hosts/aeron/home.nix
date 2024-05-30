{ config, pkgs, ... }:

# let
# 	gruvboxPlus = import ./gruvbox-plux.nix { inherit pkgs; };
# in

{
	# Home Manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "aeron";
	home.homeDirectory = "/home/aeron";

	#
	# You should not change this value, even if you update Home Manager. If you do
	home.stateVersion = "23.11"; # Please read the comment before changing.

	# Theming
	# Enabling the themes is causing issues (look onto this later)
	gtk.enable = true;
	#gtk.cursorTheme.package = pkgs.bibata-cursors;
	#gtk.cursorTheme.name = "Bibata-Modern-Ice";
	
	#gtk.theme.package = pkgs.adw-gtk3;
	#gtk.theme.name = "adw-gtk3";
	
	# gtk.iconTheme.package = pkgs.arc-icon-theme;
	# gtk.iconTheme.name = "Arc-Icon-Theme";
	# 
	qt.enable = true;
	# qt.platformTheme.name = "gtk";
	# qt.style.name = "adwaita-dark";
	# qt.style.package = pkgs.adwaita-qt;


	# The home.packages option allows you to install Nix packages into your
	home.packages = [
	# Add your packages here
	];

	home.file = {
	# # Building this configuration will create a copy of 'dotfiles/screenrc' in
	# # the Nix store. Activating the configuration will then make '~/.screenrc' a
	# # symlink to the Nix store copy.
	# ".screenrc".source = dotfiles/screenrc;

	# # You can also set the file content immediately.
	# ".gradle/gradle.properties".text = ''
	#   org.gradle.console=verbose
	#   org.gradle.daemon.idletimeout=3600000
	# '';
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/aeron/etc/profile.d/hm-session-vars.sh
	#
	home.sessionVariables = {
	EDITOR = "nvim";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
