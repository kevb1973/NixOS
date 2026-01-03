{
  config,
  pkgs,
  # inputs,
  ...
}:
let
  configSymlinks = ((import ./symlinkDots.nix) { config = config; }).configSymlinks;
  configsPath = ./dots;
  configsAbsolutePath = "/home/kev/NixOS/home/dots";
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    sessionPath = [
      "$HOME/NixOS/home/dots/bin"
    ];
    file = {
      ".bashrc".source = mkOutOfStoreSymlink "/home/kev/NixOS/home/non-xdg-dots/bash/.bashrc";
      ".local/bin".source = mkOutOfStoreSymlink "/home/kev/NixOS/home/non-xdg-dots/bin";
    };
    stateVersion = "24.05";
  };

  programs = {
    atuin.enable = true; # Shell history database
    home-manager.enable = true;
  };

  services = {
    mpd = {
      enable = true;
      network.startWhenNeeded = true;
      musicDirectory = /home/kev/Music;
      extraConfig = ''
        audio_output {
          type    "pipewire"
          name    "My Pipewire"
        }
      '';
    };
    mpdris2.enable = true;
    udiskie = {
      enable = true;
      tray = "auto";
    };
    wlsunset = {
      enable = true;
      latitude = 43.7;
      longitude = -79.4;
      temperature = {
        day = 6500;
        night = 3000;
      };
    };
  };

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };

  gtk = {
    enable = true;
    font = {
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
      size = 12;
    };

    # Theme settings
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    # Icon theme
    iconTheme = {
      package = pkgs.tela-circle-icon-theme;
      name = "Tela-circle";
    };

    # Cursor theme
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Amber";
    };

    # gtk3
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  qt.enable = true;

  systemd.user.startServices = "sd-switch";

  xdg = {
    enable = true;
    # link all subdirs in configsPath (~/NixOS/home/xdg-dots) to ~/.config
    # configSymlinks function is defined in ./symlinkDots.nix
    configFile = configSymlinks configsPath configsAbsolutePath;
  };
}
# end home.nix
