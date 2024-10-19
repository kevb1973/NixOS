_:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = false;
    # permittedInsecurePackages = [ "electron-25.9.0" ];
    };
    overlays = [(final: prev: {
        # rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
      }
    )];
  };
}
