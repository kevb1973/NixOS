{
  config,
  pkgs,
  # inputs,
  ...
}: {
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    stateVersion = "24.05";
    # packages = with pkgs; [
    # ];
    file = {
      ".config/helix".source = config.lib.file.mkOutOfStoreSymlink "/home/kev/NixOS/home/dots/helix"; 
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
    darkman = {
      enable = true;
      settings = {
        lat = 43.9;
        lng = -78.8;
      };
    };
    mpdris2.enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = false;
    font = {
      package = pkgs.cantarell-fonts;
      name = "Cantarell";
      size = 12;
    };

    # Theme settings
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    # Icon theme
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
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
}
# end home.nix

