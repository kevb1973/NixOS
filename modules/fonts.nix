{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      corefonts
      fira-code
      font-awesome
      inter
      maple-mono.NF
      material-symbols
      nerd-fonts.victor-mono
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
    ];
    fontconfig.defaultFonts = {
      monospace = [ "VictorMono Nerd Font" ];
    };
  };
}
