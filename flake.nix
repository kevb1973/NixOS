{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-trunk.url = "github:nixos/nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
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

