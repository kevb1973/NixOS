{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      font-awesome
      maple-mono-NF
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      source-code-pro
      victor-mono
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}
