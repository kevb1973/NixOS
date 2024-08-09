{ ... }:

{
  imports = [ 
   ./modules/hardware-configuration.nix
   ./modules/hardware.nix
   ./modules/network.nix
   ./modules/xdg.nix
   ./modules/systemd.nix
   ./modules/nix.nix
   ./modules/environment.nix
   ./modules/services.nix
   ./modules/fonts.nix
   ./modules/security.nix
   ./modules/virtualisation.nix
   ./modules/users.nix
   ./modules/programs.nix
   ./modules/nixpkgs.nix
   ./modules/boot.nix
  ];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  system.stateVersion = "22.11"; # Don't change unless fresh install from new ISO
}
