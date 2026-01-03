{
  config,
  pkgs,
  # inputs,
  ...
}:
let
  configLinks = (import ./symlinkDots.nix).configSymlinks;
  configsPath = ./dots;
  configsAbsolutePath = "/home/kev/NixOS/home/dots";
in
{
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    sessionPath = [
      "$HOME/NixOS/home/dots/bin"
    ];
    stateVersion = "24.05";
    # file = {
    # ".bashrc".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/bash/.bashrc";
    # ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/bin";
    # ".config/aichat".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/aichat";
    # ".config/atuin".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/atuin";
    # ".config/cava".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/cava";
    # ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/fish";
    # ".config/fuzzel".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/fuzzel";
    # ".config/gammastep".source =
    #   config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/gammastep";
    # ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/helix";
    # ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/hypr";
    # ".config/isd_tui".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/isd";
    # ".config/jj".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/jj";
    # ".config/jjui".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/jjui";
    # ".config/khal".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/khal";
    # ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/kitty";
    # ".config/lgtv".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/lgtv";
    # ".config/mango".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/mango";
    # ".config/matugen".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/matugen";
    # ".config/mpd".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/mpd";
    # ".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/mpv";
    # ".config/newsboat".source =
    #   config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/newsboat";
    # ".config/niri".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/niri";
    # ".config/television".source =
    #   config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/television";
    # ".config/wlr-which-key".source =
    #   config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/wlr-which-key";
    # ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/nvim";
    # ".config/warpd".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/warpd";
    # ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/yazi";
    # # };
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
    configFile = configLinks.configSymlinks configsPath configsAbsolutePath;
  };
}
# end home.nix
