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
      automatic = true; # Slows boot, but need to stop myself from deleting all generations!
      dates = "daily";
      options = "--delete-older-than 1d";
    };
    nixPath = [
      "/etc/nix/inputs"
    ]; # Fix <nixpkgs> for flakes. See environment.etc."nix/inputs/nixpkgs"
    optimise.automatic = true; #Auto optimize once per day at 3:45am (default)
    settings = {
      auto-optimise-store = false; # Auto optimize every build. (slow)
      builders-use-substitutes = true;
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
