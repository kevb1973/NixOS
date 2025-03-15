{ pkgs, ... }:
# Add flake-inputs to args if you need to access a flake inputs from hm.
# Then access with flake-inputs.<inputname>.module... etc

{
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    stateVersion = "24.05";
  };

  # home.packages = with pkgs; [
  # ];

  programs = {
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
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
} # end home.nix
