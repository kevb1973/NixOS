{ pkgs, inputs, ...}:
{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.lix; #pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs; # Pin nixpkgs to speed up nix commands
    gc = {
      # Auto discard system generations
      automatic = false; # disabled.. adding 10s to boot.
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
      # 24 cpus
      cores = 12;
      max-jobs = 2;
      substituters = [
        # "https://hyprland.cachix.org"
        "https://niri.cachix.org"
        # "https://cosmic.cachix.org/"
      ];
      trusted-public-keys = [ 
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" 
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        # "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
      trusted-users = [ "kev" ]; # Needed to use substituters with nix profile install/upgrade
    };
  };
}
