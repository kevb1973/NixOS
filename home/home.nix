{ pkgs, flake-inputs, ... }:
# Add flake-inputs to args if you need to access a flake inputs from hm.
# Then access with flake-inputs.<inputname>.module... etc

{
  home = {
    username = "kev";
    homeDirectory = "/home/kev";
    stateVersion = "24.05";
  };

  home.packages = with pkgs; [
    alejandra #nix code formatter
    anydesk
    at
    bemenu # For bemoji
    bemoji
    # boxbuddy # Distrobox GUI
    clifm
    dust # quick dir size for 'sys' script
    emacs30-pgtk
    fuzzel
    hydra-check # check build status.. hydra-check --channel unstable <pkg>
    keepassxc
    # lmstudio
    # nix-inspect
    (rofimoji.override { rofi = rofi-wayland; }) # Had to override otherwise ran under Xwayland
    shfmt # bash code formatter
    # typescript-language-server
    manix # search nixos and home-manager options
    markdown-oxide # markdown LS
    # neovide
    # niri
    nixd
    nodePackages.prettier
    nodePackages.prettier-plugin-toml
    raffi # Define fuzzel launcher in yaml
    rmpc # nice alternative to ncmpcpp
    see-cat #aliased to 'cat'
    swww # set background colour/wallpaper
    taplo # TOML LS
    vscode-langservers-extracted # Various LS
    wezterm
    xidel # html scraper
    xwayland-satellite # for Niri
    yad
    yaml-language-server
  ];

  programs = {
    home-manager.enable = true;
    # ncmpcpp.enable = true;
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
