{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      corefonts
      font-awesome
      maple-mono.NF
      nerd-fonts.victor-mono
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [ "VictorMono Nerd Font" ];
    };
  };
}
