{
 	description = "Flake config for hosts";
	
	inputs = {
		nixpkgs = { 
			url = "github:nixos/nixpkgs/nixos-unstable";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	
	
	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations = {
			aeron = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = {inherit inputs;};
				modules = [
					./hosts/aeron/configuration.nix
					inputs.home-manager.nixosModules.default
				];
			};
		};
	};

}
