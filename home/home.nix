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
    authenticator
    bemenu # For bemoji
    bemoji
    dust # quick dir size for 'sys' script
    emacs30-pgtk
    foot
    fuzzel
    hydra-check # check build status.. hydra-check --channel unstable <pkg>
    keepassxc
    lazyjournal
    shfmt # bash code formatter
    manix # search nixos and home-manager options
    markdown-oxide # markdown LS
    nixd
    nodePackages.prettier
    nodePackages.prettier-plugin-toml
    raffi # Define fuzzel launcher in yaml
    rmpc # nice alternative to ncmpcpp
    see-cat #aliased to 'cat'
    swww # set background colour/wallpaper
    taplo # TOML LS
    tty-solitaire
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
    dunst = {
      enable = true;
      settings = {
        global = {
          corner_radius = 10;
          follow = "none";
          font = "Hack Nerd Font";
          format = "<b>%s</b>\\n%b";
          height = 500;
          horizontal_padding = 12;
          icon_position = "left";
          idle_threshold = 5;
          ignore_newline = "no";
          monitor = 0;
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
          offset = "0x19";
          padding = 16;
          progress_bar = true;
          show_indicators = "yes";
          sticky_history = "yes";
          text_icon_padding = 16;
          transparency = 0;
          width = 370;
          word_wrap = "yes";
        };
        urgency_low = {
          background = "#0d0f16";
          foreground = "#9fa0a0";
          frame_color = "#191d24";
          highlight = "#7ba5dd";
          timeout = 3;
        };
        urgency_normal = {
          foreground = "#FFFFFF";
          background = "#073F66";
          frame_color = "#0D0F16";
          timeout = 5;
        };
        urgency_critical = {
          background = "#FF0000";
          foreground = "#FFFFFF";
          frame_color = "#000000";
          # highlight = "#EE6A70";
          timeout = 120;
        };
      };
    };
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
