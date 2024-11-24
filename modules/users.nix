{ pkgs, inputs, ... }:
{
  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups =
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" "podman" "docker" "jackaudio" "mpd" "ydotool" ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      # android-tools
      # appeditor
      archiver
      # authenticator
      # bat
      btop
      cacert
      calibre 
      # cava # Terminal audio visualizer - currently broken!
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
      grimblast
      helix
      # inputs.helix.packages.${pkgs.system}.default
      # http-server # Simple http server. Using with surfingkeys config.
      # hyprpicker
      # hyprshade
      # inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Wrapper for grim/slurp. . Using flake as nixpkgs ver pulls in old hyprland
      jq
      kdePackages.polkit-kde-agent-1
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      # kitty
      lazygit
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      # localsend
      marksman # Language server for markdown.
      mediainfo # Provides info on media files.
      (mpv.override { scripts = [ mpvScripts.mpris mpvScripts.visualizer ]; })
      mpv-shim-default-shaders
      # nautilus
      ncpamixer
      ncspot
      nh # nix helper
      # nix-prefetch-git
      nvd # Nix derivation diff tool
      # okular
      pamixer
      pavucontrol
      peaclock #TUI Clock/Stopwatch/Timer
      pistol # File preview for clifm
      playerctl
      qalculate-gtk
      ripgrep
      rofi-wayland
      # scrcpy
      slurp
      # steam-run
      # stellarium
      stow
      # swaybg
      # swayidle
      # swaylock
      swaynotificationcenter
      syncthing
      tealdeer # Command line help 'tldr'
      # treesheets
      tree-sitter
      virt-manager
      vlc
      wakeonlan # For lgtv control
      waybar
      # inputs.waybar.packages.${pkgs.system}.waybar
      waypaper
      websocat # For lgtv control
      # wttrbar
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
      # zim
      zoxide
    ];
  };
}
