{
  description = "Flake config for my machine";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    aeronvim-nix = {
      url = "github:AeronSor/aeronvim-nix";
    };

    musnix = { url = "github:musnix/musnix"; };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    aeronvim-nix,
    musnix,
    ...
  }: {
    nixosConfigurations = {
      aeron = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./system/configuration.nix
          musnix.nixosModules.musnix

          # Setup Home manager
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.aeron = import ./home-manager/home.nix;
          # }
        ];
      };
    };
  };
}
