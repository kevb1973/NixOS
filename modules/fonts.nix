{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      corefonts
      noto-fonts-lgc-plus
      nerd-fonts.victor-mono
      maple-mono.NF
      font-awesome
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [ "VictorMono Nerd Font" ];
    };
  };
}
