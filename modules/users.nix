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
      "keyd"
      "kvm"
      "libvirtd"
      "mpd"
      "networkmanager"
      "podman"
      "seat"
      "wheel"
      # "ydotool"
    ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      adw-gtk3
      aichat
      # anydesk
      aria2
      at
      authenticator
      bat
      bemoji
      bluetuith
      boxbuddy
      btop
      cacert
      # calibre  # BROKEN again. Switched to flatpak
      cargo
      cava # Terminal audio visualizer
      # clipse
      cliphist # Clipboard manager (for DankMaterialShell)
      # colloid-gtk-theme
      # colloid-icon-theme
      copyq # clipboard manager++ 
      cotp # CLI OTP/2FA code provider
      darkman
      ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      distrobox
      distrobox-tui
      dotool # daemonless replacement for ydotool
      dust # quick dir size for 'sys' script
      emacs-pgtk
      espanso-wayland # Service not working with Niri. Starting manually.
      fd
      ffmpeg
      file
      file-roller
      fish-lsp
      fishPlugins.fzf
      fishPlugins.grc
      # fishPlugins.tide
      foliate
      fuzzel
      fzf
      gammastep # Prfer sunsetr as No geoclue2 needed, but this is supported by DankMaterialShell.
      gdu # Disk space analyzer
      geoclue2 # Needed for gammastep auto localation
      gitui # Another terminal git helper
      gnome-boxes
      gnome-software # Install and manage flatpaks
      gnome-themes-extra
      grc # colourizer for fishPlugins.grc
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      grimblast
      gum # Script enhancer - use for remind_tui
      highlight # Used with vifm to add color to file previews with code
      hydra-check # check build status.. hydra-check --channel unstable <pkg>
      igrep # interactive grep->edit@line. cmd:ig 
      inxi # Hardware info app
      # isd # Systemd tui (moved to user profile using flake for newer version)
      jamesdsp
      # jjui # Moved to nix profile install to track github
      jq
      jujutsu
      kdePackages.polkit-kde-agent-1
      kdePackages.qt6ct
      kdePackages.qtmultimedia
      kdePackages.qtstyleplugin-kvantum
      keyd # For some reason binaries not in path for service
      khal # Local Calendar used by DankMaterialShell 
      kitty
      kitty-themes
      lazygit
      lazyjournal # tui for logs
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      libtool # Needed for DMS
      llama-cpp-vulkan
      lsd
      # lmstudio # LLM server
      manix # search nixos and home-manager options
      markdown-oxide # markdown LS
      marksman
      matugen # For quickshell - DankMaterialShell
      mdcat # cat/less for markdown
      mediainfo # Provides info on media files.
      micro-with-wl-clipboard # simple editor for jujutsu
      mpv-shim-default-shaders
      multimarkdown # Markdown preview in emacs
      nautilus
      ncpamixer
      nettools
      networkmanagerapplet
      nh # nix helper
      nil # for zed-editor
      # nix-search-cli
      nix-search-tv # Search nixos/home-manager options + nixpkgs/nur with 'television'
      nix-tree
      nixd
      nixfmt-rfc-style # official nix code formatter
      nodePackages.prettier
      nodejs # Need for Neovim Mason
      nushell # cuz its cool (and easier than jq)
      nvd # Nix derivation diff tool
      nwg-look # Wayland replacement for lxappearance. Set gtk themes, icons, cursors etc.
      optnix
      p7zip
      # pamixer # BROKEN: 2025-10-7
      # pavucontrol
      pinta # Simple image editor
      pwvucontrol # Pipewire GUI mixer
      peaclock # TUI Clock/Stopwatch/Timer
      playerctl
      podman-compose
      podman-tui
      pywalfox-native # Native component for pywalfox extension
      qalculate-gtk
      # quickshell # For quickshell - DankMaterialShell (using flake for newer version)
      regctl # Needed for?
      ripgrep
      rmpc # nice alternative to ncmpcpp
      shellcheck # Needed for doom emacs
      shfmt # bash code formatter
      simple-completion-language-server
      sioyek # nice pdf viewer
      slurp
      snore # sleep, with feedback
      spotify
      spotify-player
      starship # Nice prompt
      stow
      swayimg
      swaynotificationcenter
      swww # wallpaper setter for matugen
      # syncthing
      tealdeer # Command line help 'tldr'
      television # Similar to fzf. Using with nix-search-tv
      tombi # Newer TOML LS
      tree-sitter
      uv # Wiki says this is an easy way to manage python versions and packages (non-declarative)
      uwu-colors
      vdirsyncer # Sync web calendar to khal for DankMaterialShell 
      video-downloader
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
      wtype # For wofi-emoji or walker
      xdg-user-dirs
      xwayland-satellite # for Niri
      yad
      yaml-language-server
      yazi
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
