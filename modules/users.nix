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
      adw-gtk3
      aria2
      # authenticator
      bat
      btop
      cacert
      calibre 
      cargo
      cava # Terminal audio visualizer 
      clipse
      ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      emacs-pgtk
      eza
      fd
      file
      fishPlugins.tide
      fishPlugins.grc
      fishPlugins.fzf
      foliate
      fuzzel
      fzf
      # gcc
      gdu # Disk space analyzer
      gitui #Another terminal git helper
      grc # colourizer for fishPlugins.grc
      file-roller
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      grimblast 
      highlight # Used with vifm to add color to file previews with code
      jq
      kdePackages.polkit-kde-agent-1
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      kitty
      kitty-themes
      lazygit
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      lmstudio
      lsd # colorful ls
      mediainfo # Provides info on media files.
      mpc # For emacs simple-mpc
      (mpv.override { scripts = [ mpvScripts.mpris mpvScripts.visualizer mpvScripts.modernz ]; })
      mpv-shim-default-shaders
      nautilus
      ncpamixer
      # ncspot
      networkmanagerapplet
      nh # nix helper
      nix-search-cli
      nix-tree
      nodejs # Need for Neovim Mason
      nvd # Nix derivation diff tool
      p7zip
      pamixer
      pavucontrol
      peaclock #TUI Clock/Stopwatch/Timer
      # pistol # File preview for clifm
      # play # TUI grep/sed/awk playground
      playerctl
      podman-compose
      podman-desktop
      podman-tui
      qalculate-gtk
      regctl # Needed for 
      ripgrep
      # rofi-wayland
      simple-completion-language-server
      slurp
      stow
      swayimg
      swaynotificationcenter
      # syncthing
      tealdeer # Command line help 'tldr'
      tree-sitter
      video-downloader
      vifm
      # virt-manager
      vlc
      wakeonlan # For lgtv control
      # walker # Switched to flake due to bug and slow nixpkgs updates
      waypaper
      websocat # For lgtv control
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wlogout
      wtype # For wofi-emoji or walker
      xdg-user-dirs
      xwayland-run
      yazi
      ydotool
      yt-dlp
      zathura
      zoxide
      alejandra # nix code formatter
      # anydesk
      at
      authenticator
      dust # quick dir size for 'sys' script
      hydra-check # check build status.. hydra-check --channel unstable <pkg>
      # keepassxc
      lazyjournal # tui for logs
      shfmt # bash code formatter
      manix # search nixos and home-manager options
      markdown-oxide # markdown LS
      marksman
      nixd
      nodePackages.prettier
      rmpc # nice alternative to ncmpcpp
      spotify
      spotify-player
      swaynotificationcenter
      taplo # TOML LS
      vifm
      vscode-langservers-extracted # Various LS
      # wezterm
      wlr-which-key
      xwayland-satellite # for Niri
      yad
      yaml-language-server
    ];
  };
}
