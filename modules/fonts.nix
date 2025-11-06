{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      corefonts
      fira-code
      fira-sans
      font-awesome
      inter
      input-fonts
      maple-mono.NF
      material-symbols
      nerd-fonts.victor-mono
      noto-fonts
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [ "VictorMono Nerd Font" ];
    };
  };
  nixpkgs.config.input-fonts.acceptLicense = true; # Needed for unfree font
}
