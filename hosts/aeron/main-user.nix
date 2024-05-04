{lib, config, pkgs, ...}:
{
	options = {
		main-user.enable = lib.mkEnableOption "Enable user module";

		main-user.userName = lib.mkOption {
			default = "mainuser";
			description = ''
			  username
			'';
		};

	};

	config = lib.mkIf config.main-user.enable {
		users.users.${config.main-user.userName} = {
			isNormalUser = true;
			description = "Main user";
			extraGroups = [ "wheel" ]; # Enable sudo
		};
	};

}
