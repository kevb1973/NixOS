{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, ... }: {
    nixosConfigurations = {
      halcyon = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ({ pkgs, ... }: {
            nix.registry.sys = {
              from = {
                type = "indirect";
                id = "sys";
              };
              flake = nixpkgs;
            };
          })
        ];
      };
    };
  };
}

