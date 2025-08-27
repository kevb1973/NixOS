{ pkgs, inputs, ... }:
{
  users.users.kev = {
    initialPassword = "password"; # Change after a fresh install with passwd
    isNormalUser = true;
    description = "kev";
    linger = true; # Auto start user systemd units at boot. Keep running on logout.
    extraGroups = [
      "adbusers"
      "audio"
      "input"
      "kvm"
      "libvirtd"
      "mpd"
      "networkmanager"
      "podman"
      "wheel"
      # "ydotool"
    ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      # anydesk
      # authenticator
      # syncthing
      adw-gtk3
      aichat
      aria2
      at
      authenticator
      bat
      bemoji
      boxbuddy
      btop
      cacert
      calibre
      cargo
      cava # Terminal audio visualizer
      # clipse
      cliphist # Clipboard manager (for DankMaterialShell)
      colloid-gtk-theme
      colloid-icon-theme
      colloid-kde
      ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      distrobox
      distrobox-tui
      dotool # daemonless replacement for ydotool
      dust # quick dir size for 'sys' script
      emacs-pgtk
      eza #colourful ls
      fd
      file
      file-roller
      fishPlugins.fzf
      fishPlugins.grc
      fishPlugins.tide
      foliate
      fuzzel
      fzf
      # gammastep # Switch to sunsetr. No geoclue2 needed. Not killed by DankMaterialShell.
      gdu # Disk space analyzer
      # geoclue2 # Needed for gammastep auto localation
      gitui # Another terminal git helper
      gnome-boxes
      gnome-software # Install and manage flatpaks
      gnome-themes-extra
      grc # colourizer for fishPlugins.grc
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      grimblast
      highlight # Used with vifm to add color to file previews with code
      hydra-check # check build status.. hydra-check --channel unstable <pkg>
      inxi # Hardware info app
      isd # Systemd tui
      jamesdsp
      jq
      kdePackages.polkit-kde-agent-1
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      khal # Local Calendar used by DankMaterialShell
      kitty
      kitty-themes
      lazygit
      lazyjournal # tui for logs
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      # lsd # colorful ls
      manix # search nixos and home-manager options
      markdown-oxide # markdown LS
      marksman
      matugen # For quickshell - DankMaterialShell
      mediainfo # Provides info on media files.
      mpv-shim-default-shaders
      multimarkdown # Markdown preview in emacs
      nautilus
      ncpamixer
      nettools
      # networkmanagerapplet
      nh # nix helper
      nil # for zed-editor
      nix-search-cli
      nix-tree
      nixd
      nixfmt-rfc-style # official nix code formatter
      nodePackages.prettier
      nodejs # Need for Neovim Mason
      nvd # Nix derivation diff tool
      nwg-look # Wayland replacement for lxappearance. Set gtk themes, icons, cursors etc.
      p7zip
      pamixer
      # pavucontrol
      pwvucontrol # Pipewire GUI mixer
      peaclock # TUI Clock/Stopwatch/Timer
      playerctl
      podman-compose
      podman-desktop
      podman-tui
      pywalfox-native # Native component for pywalfox extension
      qalculate-gtk
      quickshell # For quickshell - DankMaterialShell
      regctl # Needed for
      ripgrep
      rmpc # nice alternative to ncmpcpp
      shellcheck # Needed for doom emacs
      shfmt # bash code formatter
      simple-completion-language-server
      sioyek # nice pdf viewer
      slurp
      spotify
      spotify-player
      stow
      sunsetr
      swayimg
      swaynotificationcenter
      swww # wallpaper setter for matugen
      # taplo # TOML LS
      tealdeer # Command line help 'tldr'
      tombi # Newer TOML LS
      tree-sitter
      vdirsyncer # Sync web calendar to khal for DankMaterialShell
      video-downloader
      vifm
      virt-manager
      # vivaldi
      # vivaldi-ffmpeg-codecs
      vlc
      vscode-langservers-extracted # Various LS
      wakeonlan # For lgtv control
      waypaper
      websocat # For lgtv control
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wlogout
      wlr-which-key
      wlsunset # Screen temp change for DankMaterialShell
      wtype # For wofi-emoji or walker
      xdg-user-dirs
      # xwayland-satellite # for Niri
      inputs.xwayland-satellite.packages.${pkgs.system}.default
      yad
      yaml-language-server
      yazi
      # ydotool
      yt-dlp
      zoxide
      (mpv.override {
        scripts = [
          mpvScripts.mpris
          mpvScripts.visualizer
          mpvScripts.modernz
        ];
      })
    ];
  };
}
