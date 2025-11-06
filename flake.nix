{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = {
    nixpkgs,
    home-manager,
    mango,
    ...
  }@inputs: {
    nixosConfigurations = {
      halcyon = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit system inputs;};
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          mango.nixosModules.mango
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
