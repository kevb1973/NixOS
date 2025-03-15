{ pkgs, inputs, ... }:
{
  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups =
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" "podman" "docker" "jackaudio" "mpd" "ydotool" ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      # authenticator
      # bat
      btop
      cacert
      calibre 
      cava # Terminal audio visualizer 
      cliphist
      # ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      # distrobox
      # emacs29-pgtk
      # emacsPackages.all-the-icons-nerd-fonts
      eza
      fd
      # feh
      file
      fishPlugins.tide
      fishPlugins.puffer
      fishPlugins.grc
      fishPlugins.fzf
      fishPlugins.autopair
      foliate
      fzf
      # gcc
      gdu # Disk space analyzer
      gitui #Another terminal git helper
      file-roller
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      # grimblast # commented as not using in Niri and it pulls full Hyprland in
      # helix # Following flake in user profile
      # inputs.helix.packages.${pkgs.system}.default
      # http-server # Simple http server. Using with surfingkeys config.
      # hyprpicker
      # hyprshade
      # inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Wrapper for grim/slurp. . Using flake as nixpkgs ver pulls in old hyprland
      jq
      kdePackages.polkit-kde-agent-1
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      lazygit
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      mediainfo # Provides info on media files.
      (mpv.override { scripts = [ mpvScripts.mpris mpvScripts.visualizer ]; })
      mpv-shim-default-shaders
      ncpamixer
      ncspot
      nh # nix helper
      nvd # Nix derivation diff tool
      pamixer
      pavucontrol
      peaclock #TUI Clock/Stopwatch/Timer
      pistol # File preview for clifm
      playerctl
      qalculate-gtk
      ripgrep
      rofi-wayland
      slurp
      stow
      swaynotificationcenter
      syncthing
      tealdeer # Command line help 'tldr'
      tree-sitter
      virt-manager
      vlc
      wakeonlan # For lgtv control
      waybar
      waypaper
      websocat # For lgtv control
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wlogout
      wtype # For wofi-emoji
      xdg-user-dirs
      yazi
      ydotool
      yt-dlp
      zathura
      zoxide
      #From Home-Manager
      
      alejandra # nix code formatter
      anydesk
      at
      authenticator
      bemenu # For bemoji
      bemoji
      dust # quick dir size for 'sys' script
      # emacs30-pgtk
      foot
      # fuzzel
      hydra-check # check build status.. hydra-check --channel unstable <pkg>
      keepassxc
      lazyjournal # tui for logs
      shfmt # bash code formatter
      manix # search nixos and home-manager options
      markdown-oxide # markdown LS
      marksman
      nixd
      nodePackages.prettier
      nodePackages.prettier-plugin-toml
      raffi # Define fuzzel launcher in yaml
      rmpc # nice alternative to ncmpcpp
      see-cat # aliased to 'cat'
      spotify
      swaynotificationcenter
      swww # set background colour/wallpaper
      taplo # TOML LS
      television
      tty-solitaire
      vscode-langservers-extracted # Various LS
      # wezterm
      xidel # html scraper
      xwayland-satellite # for Niri
      yad
      yaml-language-server
    ];
  };
}
