{ pkgs, ... }:
{
  users = {
    groups = {
      # Add extra groups
      adbusers = { };
      media = { };
      mpd = { };
      storage = { };
    };
    users.kev = {
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
        "media"
        "mpd"
        "networkmanager"
        "podman"
        "seat"
        "storage"
        "wheel"
      ];

      packages = with pkgs; [
        adw-gtk3
        aria2
        at
        authenticator
        bat
        bemoji
        bluetuith
        boxbuddy
        cacert
        # calibre # BROKEN again. Switched to flatpak
        cantata # GUI MPD client
        cargo
        cava # Terminal audio visualizer
        cliphist # Clipboard manager (for DankMaterialShell)
        clock-rs # stopwatch, timers, clock
        # copyq # clipboard manager++ (disabled as using DMS built-in clipboard manager)
        cotp # CLI OTP/2FA code provider - only use for bitwarden which manages all the rest
        ddcutil # Adjust monitor brightness and other settings from cli
        dgop # System Info for DankMaterialShell
        diff-so-fancy
        distrobox
        dust # quick dir size for 'sys' script
        emacs-pgtk
        fd
        ffmpeg
        file
        file-roller
        fish-lsp
        fishPlugins.fzf
        fishPlugins.grc
        foliate
        fuzzel # Using for emoji-picker script
        fzf
        gdu # Disk space analyzer
        geoclue2 # Needed for gammastep auto localation
        gnome-boxes
        gnome-software # Install and manage flatpaks
        gnome-themes-extra
        grc # generic text colourizer. Using with fishPlugins.grc
        gum # Script enhancer - use for remind_tui
        hydra-check # check build status.. hydra-check --channel unstable <pkg>
        hyprpicker # Simple color picker with zoom and hex preview
        # hyprshot # Wayland screenshots (removed as pulling in hyprland!)
        serpl # Neat tui find/replace in project
        systemctl-tui # Manage systemd units
        jq
        jujutsu
        kdePackages.polkit-kde-agent-1
        kdePackages.qt6ct
        kdePackages.qtmultimedia
        kdePackages.qtstyleplugin-kvantum
        khal # Local Calendar used by DankMaterialShell
        kitty
        kitty-themes
        lazyjournal # tui for logs
        libnotify
        libsForQt5.qtstyleplugin-kvantum
        libtool # Needed for DMS
        llama-cpp-vulkan
        lsd
        lswt # Find app-id and title for mangowm
        markdown-oxide # markdown LS
        marksman
        matugen # For quickshell - DankMaterialShell
        mdcat # cat/less for markdown
        mediainfo # Provides info on media files.
        micro-with-wl-clipboard # simple editor for jujutsu
        mpv-shim-default-shaders
        nautilus
        ncpamixer
        neovide
        nettools
        newsboat
        nh # nix helper
        nil # for zed-editor
        nix-search-tv # Search nixos/home-manager options + nixpkgs/nur with 'television'
        nix-tree
        nixd
        nodePackages.prettier
        nodejs # Need for Neovim Mason
        nushell # cuz its cool (and easier than jq)
        nvd # Nix derivation diff tool
        nvtopPackages.amd # htop for video cards
        optnix
        p7zip
        pamixer
        pwvucontrol # Pipewire GUI mixer
        playerctl
        podman-compose
        podman-tui
        puddletag # Music tag editor
        python3
        qalculate-gtk
        quickshell
        ripgrep
        rmpc # nice alternative to ncmpcpp
        satty # Screenshot Editor
        shellcheck # Needed for doom emacs
        shfmt # bash code formatter
        sioyek # nice pdf viewer
        snore # sleep, with feedback
        spotify
        spotify-player
        statix # Lints and suggestions for nix. Need for lazyvim.
        swww # wallpaper setter for matugen
        tealdeer # Command line help 'tldr'
        television # Similar to fzf. Using with nix-search-tv
        tombi # Newer TOML LS
        treemd # TUI Markdown viewer (used for tv niri-wiki)
        tree-sitter
        udiskie # For access to cli only. Service enabled in home-manager
        uv # Wiki says this is an easy way to manage python versions and packages (non-declarative)
        uwu-colors # LSP to display color swatches
        vdirsyncer # Sync web calendar to khal for DankMaterialShell
        virt-manager
        # vivaldi
        # vivaldi-ffmpeg-codecs
        vscode-langservers-extracted # Various LS
        wakeonlan # For lgtv control
        websocat # For lgtv control
        wev
        wget
        wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
        wl-color-picker
        wl-kbptr # click via keyboard (like vimium for niri)
        wlogout
        wlrctl # alternate to dotool (move mouse off screen)
        wlr-which-key
        wtype # For wofi-emoji or walker
        xdg-user-dirs
        xwayland-satellite # for Niri
        yaml-language-server
        yazi
        ydotool # Using to autopaste emojis (bemoji)
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
  };
}
# vim: foldlevel=99
