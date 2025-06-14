{ ... }:

{
  imports = [ 
   ./modules/boot.nix
   ./modules/environment.nix
   ./modules/fonts.nix
   ./modules/hardware-configuration.nix
   ./modules/hardware.nix
   ./modules/network.nix
   ./modules/nix.nix
   ./modules/nixpkgs.nix
   ./modules/programs.nix
   ./modules/security.nix
   ./modules/services.nix
   ./modules/systemd.nix
   ./modules/users.nix
   ./modules/virtualisation.nix
   ./modules/xdg.nix  
  ];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  system.stateVersion = "22.11"; # Don't change unless fresh install from new ISO

  documentation.man = {
    man-db.enable = false;
    mandoc.enable = true;
  };
}
