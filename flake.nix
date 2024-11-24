{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-cli.url = "github:water-sucks/nixos";
    nixos-cli.inputs.nixpkgs.follows = "nixpkgs";
    # helix.url = "github:helix-editor/helix";
    niri.url = "github:sodiboo/niri-flake";
    rust-overlay.follows = ""; #disable unneeded dev stuff for niri flake
    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    # nixpkgs-trunk.url = "github:nixos/nixpkgs";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-contrib.url = "github:hyprwm/contrib";
    # hyprland-contrib.inputs.nixpkgs.follows = "nixpkgs";
    # hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    # hyprland-plugins.inputs.hyprland.follows = "hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-cli, niri, ... }: {
    nixosConfigurations = {
      halcyon = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          nixos-cli.nixosModules.nixos-cli
          niri.nixosModules.niri
          # nixos-cosmic.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kev = import ./home/home.nix;
              extraSpecialArgs.flake-inputs = inputs;
            };
          }
        ];
      };
    };
  };
}
