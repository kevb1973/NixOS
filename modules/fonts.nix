{ config, pkgs, lib, ...}:
{
  fonts = {
    # fontDir.enable = true;
    packages = with pkgs; [
      font-awesome
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      source-code-pro
      victor-mono
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}
