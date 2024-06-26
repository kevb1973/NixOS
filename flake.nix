{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs-trunk.url = "github:nixos/nixpkgs";
    # niri.url = "github:sodiboo/niri-flake";
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-contrib = {
    #   url = "github:hyprwm/contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    waybar.url = "github:Alexays/Waybar";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
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
          # niri.nixosModules.niri
          # {
          #   programs.niri.enable = true;
          # }
          # { # If you wish to use the unstable version of niri, you can set it like so:
          #   nixpkgs.overlays = [ niri.overlays.niri ];
          #   # programs.niri.package = pkgs.niri-unstable;
          # }
        ];
      };
    };
  };
}
