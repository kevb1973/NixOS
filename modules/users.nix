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
        btrfs-progs
        cacert
        calibre 
        cantata # GUI MPD client
        cargo
        cava # Terminal audio visualizer
        cliphist # Clipboard manager (for DankMaterialShell)
        clock-rs # stopwatch, timers, clock
        # copyq # clipboard manager++ (disabled as using DMS built-in clipboard manager)
        cotp # CLI OTP/2FA code provider - only use for bitwarden which manages all the rest
        ddcutil # Adjust monitor brightness and other settings from cli
        dgop # System Info for DankMaterialShell
        distrobox
        dust # quick dir size for 'sys' script
        emacs-pgtk
        fastfetch # System info for Noctalia-Shell
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
        helix # Modal Editor
        hydra-check # check build status.. hydra-check --channel unstable <pkg>
        hyprpicker # Simple color picker with zoom and hex preview
        # hyprshot # Wayland screenshots (removed as pulling in hyprland!)
        seahorse # GUI for system passwords
        serpl # Neat tui find/replace in project
        systemctl-tui # Manage systemd units
        jjui # GUI for Jujutsu
        jq
        jujutsu
        kdePackages.polkit-kde-agent-1
        kdePackages.qt6ct
        kdePackages.qtmultimedia
        kdePackages.qtstyleplugin-kvantum
        khal # Local Calendar used by DMS
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
        nettools
        newsboat
        nh # nix helper
        nil # for zed-editor
        nix-search-cli
        nix-tree
        nixd
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
        shellcheck 
        shfmt # bash code formatter
        sioyek # nice pdf viewer
        snore # sleep, with feedback
        spotify
        spotify-player
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
        wtype # For wofi-emoji or walker
        xdg-user-dirs
        xwayland-satellite # for Niri
        yaml-language-server
        yazi
        ydotool # Using to autopaste emojis (bemoji)
        yt-dlp
        zellij # Terminal multiplexer
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
