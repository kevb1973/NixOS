{ pkgs, inputs, ... }:
{
  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups =
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" "podman" "docker" "jackaudio" "mpd" ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      alacritty
      # android-tools
      appeditor
      arc-theme
      archiver
      audacious
      authenticator
      bat
      btop
      cacert
      calibre
      cargo
      cava # Terminal audio visualizer
      celestia
      clifm
      cliphist
      clinfo
      ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      discord
      distrobox
      dracula-theme
      emacs29-pgtk
      emacsPackages.all-the-icons-nerd-fonts
      eza
      fd
      feh
      file
      fishPlugins.tide
      fishPlugins.puffer
      fishPlugins.grc
      fishPlugins.fzf
      fishPlugins.autopair
      foliate
      fzf
      gammastep
      gcc
      gdu # Disk space analyzer
      gh # Github helper.. needed for emacs consult-gh package
      gitui #Another terminal git helper
      file-roller
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      grimblast
      gucharmap
      helix
      http-server # Simple http server. Using with surfingkeys config.
      hyprpicker
      hyprshade
      # inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Wrapper for grim/slurp. . Using flake as nixpkgs ver pulls in old hyprland
      jc # Convert output to json for many utils. Useful with Nushell
      jgmenu
      jq
      kdePackages.kalarm
      kdePackages.polkit-kde-agent-1
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      kitty
      lazygit
      libnotify
      libsForQt5.qtstyleplugin-kvantum
      # localsend
      marksman # Language server for markdown.
      mediainfo # Provides info on media files.
      meld
      (mpv.override { scripts = [ mpvScripts.mpris mpvScripts.visualizer ]; })
      mpv-shim-default-shaders
      nautilus
      ncdu
      ncpamixer
      ncspot
      nh # nix helper
      nix-prefetch-git
      nix-search-cli
      nvd # Nix derivation diff tool
      okular
      pamixer
      pavucontrol
      peaclock #TUI Clock/Stopwatch/Timer
      pistol # File preview for clifm
      playerctl
      qalculate-gtk
      qmplay2
      ripgrep
      rofi-wayland
      scrcpy
      slurp
      steam-run
      stellarium
      stow
      swaybg
      swayidle
      swaylock
      swaynotificationcenter
      syncthing
      tealdeer # Command line help 'tldr'
      treesheets
      ueberzugpp
      tree-sitter
      virt-manager
      vlc
      wakeonlan # For lgtv control
      # waybar
      inputs.waybar.packages.${pkgs.system}.waybar

      waypaper
      websocat # For lgtv control
      wttrbar
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wlogout
      wtype # For wofi-emoji
      xdg-user-dirs
      yad
      yazi
      ydotool
      yt-dlp
      zathura
      zim
      zoxide
    ];
  };
}
