{ config, pkgs, lib, inputs, ...}:
{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs; # Pin nixpkgs to speed up nix commands
    gc = {
      # Auto discard system generations
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    nixPath = [
      "/etc/nix/inputs"
    ]; # Fix <nixpkgs> for flakes. See environment.etc."nix/inputs/nixpkgs"
    optimise.automatic = true; #Auto optimize once per day at 3:45am (default)
    settings = {
      auto-optimise-store = false; # Auto optimize nix store (disabled due to slowing down rebuilds).
      builders-use-substitutes = true;
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };
}
