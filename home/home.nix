{ pkgs, ... }:

{
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    stateVersion = "24.05";
  };

  home.packages = with pkgs; [
    anydesk
    boxbuddy                                            # Distrobox GUI
    dust                                                # Rust disk usage calculator
    lmstudio
    nix-inspect
    (rofimoji.override { rofi = rofi-wayland; })        # Had to override otherwise ran under Xwayland
    typescript-language-server
    manix                                               # search nixos and home-manager options
    markdown-oxide                                      # markdown LS
    neovide
    nixd
    nodePackages.prettier
    nodePackages.prettier-plugin-toml
    taplo                                               # TOML LS
    vscode-langservers-extracted                        # Various LS 
    yaml-language-server
  ];

  programs = {
    home-manager.enable = true;
    ncmpcpp.enable = true;
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
