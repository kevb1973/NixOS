{
  config,
  pkgs,
  inputs,
  ...
}: {
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    stateVersion = "24.05";
  };

  home.packages = with pkgs; [
    (python3.withPackages (ps: with ps; [
        (inputs.ignis.packages.${pkgs.stdenv.hostPlatform.system}.ignis.override {
          extraPackages = [
            # Add extra packages if needed
          ];
        })
      ]))
  ];

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
    enable = false;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
  };

  qt.enable = true;

  systemd.user.startServices = "sd-switch";
}
# end home.nix

