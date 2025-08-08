{ pkgs, ... }:
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
      "ydotool"
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
      clipse
      ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      distrobox
      distrobox-tui
      dust # quick dir size for 'sys' script
      emacs-pgtk
      eza
      fd
      file
      file-roller
      fishPlugins.fzf
      fishPlugins.grc
      fishPlugins.tide
      foliate
      fuzzel
      fzf
      gdu # Disk space analyzer
      gitui # Another terminal git helper
      grc # colourizer for fishPlugins.grc
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      grimblast
      highlight # Used with vifm to add color to file previews with code
      hydra-check # check build status.. hydra-check --channel unstable <pkg>
      jamesdsp
      jq
      kdePackages.polkit-kde-agent-1
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      kitty
      kitty-themes
      lazygit
      lazyjournal # tui for logs
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      lsd # colorful ls
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
      networkmanagerapplet
      nh # nix helper
      nil # for zed-editor
      nix-search-cli
      nix-tree
      nixd
      nixfmt-rfc-style # official nix code formatter
      nodePackages.prettier
      nodejs # Need for Neovim Mason
      nvd # Nix derivation diff tool
      p7zip
      pamixer
      pavucontrol
      peaclock # TUI Clock/Stopwatch/Timer
      playerctl
      podman-compose
      podman-desktop
      podman-tui
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
      swayimg
      swaynotificationcenter
      swaynotificationcenter
      systemctl-tui
      sysz # fzf systemd interface
      taplo # TOML LS
      tealdeer # Command line help 'tldr'
      tree-sitter
      video-downloader
      vifm
      virt-manager
      vivaldi
      vivaldi-ffmpeg-codecs
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
      wtype # For wofi-emoji or walker
      xdg-user-dirs
      xwayland-run
      xwayland-satellite # for Niri
      yad
      yaml-language-server
      yazi
      ydotool
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
