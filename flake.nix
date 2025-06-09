{
  description = "Halcyon System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";
    nixos-cli.url = "github:nix-community/nixos-cli";
    # hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    niri,
    nixos-cli,
    ...
  }: {
    nixosConfigurations = {
      halcyon = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kev = import ./home/home.nix;
              extraSpecialArgs.flake-inputs = inputs;
            };
          }
          niri.nixosModules.niri
          nixos-cli.nixosModules.nixos-cli
        ];
      };
    };
  };
}
