{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      font-awesome
      maple-mono.NF
      nerd-fonts.hack
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      victor-mono
    ];
  };
}
