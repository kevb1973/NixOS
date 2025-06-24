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

      # ignis = {
      #   url = "github:ignis-sh/ignis";
      #   inputs.nixpkgs.follows = "nixpkgs";
      # };
  };

  outputs = {
    nixpkgs,
    home-manager,
    niri,
    nixos-cli,
    ...
  }@inputs: {
    nixosConfigurations = {
      halcyon = nixpkgs.lib.nixosSystem rec {
        specialArgs = {inherit system inputs;};
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kev = import ./home/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
          niri.nixosModules.niri
          nixos-cli.nixosModules.nixos-cli
        ];
      };
    };
  };
}
