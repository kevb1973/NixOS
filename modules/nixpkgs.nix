{ inputs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = false;
    # permittedInsecurePackages = [ "electron-25.9.0" ];
    };
    # overlays = [ inputs.niri.overlays.niri ];
  };
}
