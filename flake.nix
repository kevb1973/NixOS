{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { nixpkgs, home-manager, ... }: 
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {
    nixosConfigurations = {
      halcyon = lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          # Pin nixpkgs so nix commands don't redownload the registry every time
          { nix.registry.self.flake = nixpkgs;}
        ];
      };
    };
  };
}
