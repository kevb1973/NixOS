{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };


  };

  outputs = {
    nixpkgs,
    home-manager,
    determinate,
    ...
  }@inputs: {
    nixosConfigurations = {
      halcyon = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit system inputs;};
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          determinate.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kev = ./home/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    };
  };
}
