{
  config,
  pkgs,
  # inputs,
  ...
}:
{
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    sessionPath = [
      "$HOME/NixOS/home/dots/bin"
    ];
    stateVersion = "24.05";
    # packages = with pkgs; [
    # ];
    file = {
      ".bashrc".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/bash/.bashrc";
      ".local/bin".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/bin";
      ".config/aichat".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/aichat";
      ".config/atuin".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/atuin";
      ".config/cava".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/cava";
      ".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/fish";
      ".config/fuzzel".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/fuzzel";
      ".config/gammastep".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/gammastep";
      ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/helix";
      ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/hypr";
      ".config/isd_tui".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/isd";
      ".config/jjui".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/jjui";
      ".config/khal".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/khal";
      ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/kitty";
      ".config/lgtv".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/lgtv";
      ".config/mango".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/mango";
      ".config/matugen".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/matugen";
      ".config/mpd".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/mpd";
      ".config/mpv".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/mpv";
      ".config/niri".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/niri";
      ".config/television".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/television";
      ".config/wlr-which-key".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/wlr-which-key";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/nvim";
      ".config/yazi".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/yazi";
    };

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
    # darkman = {
    #   enable = false;
    #   darkModeScripts = {
    #     dank-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       /home/kev/Code/dms-bin/dms ipc theme dark
    #     '';
    #     firefox-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
    #     '';
    #     helix-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       pkill --signal USR1 hx
    #     '';
    #     micro-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       sed -i -e 's/"geany"/"default"/g' ~/.config/micro/settings.json
    #     '';
    #   };
    #   lightModeScripts = {
    #     dank-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       /home/kev/Code/dms-bin/dms ipc theme light
    #     '';
    #     firefox-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
    #     '';
    #     helix-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       pkill --signal USR1 hx
    #     '';
    #     micro-theme = ''
    #       export PATH="$PATH:/home/kev/NixOS/home/dots/bin"
    #       sed -i -e 's/"default"/"geany"/g' ~/.config/micro/settings.json
    #     '';
    #   };
    #   settings = {
    #     lat = 43.9;
    #     lng = -78.8;
    #   };
    # };
    mpdris2.enable = true;
    udiskie = {
      enable = true;
      tray = "auto";
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
  xdg.enable = true;
}
# end home.nix
