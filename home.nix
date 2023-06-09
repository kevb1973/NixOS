{ config, pkgs, ... }:

{
  home.username = "kev";
  home.homeDirectory = "/home/kev";
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    anydesk
    appeditor
    broot
    cheat
    fishPlugins.tide
    gcc
    gnome.gnome-clocks
    gnome.file-roller
    gucharmap
    jgmenu
    kde-gtk-config
    logseq
    mplayer
    ncdu
    ncpamixer
    newsboat
    nix-prefetch-git
    nvd
    obsidian
    pamixer
    pavucontrol
    playerctl
    pulsemixer
    ripgrep
    rust-analyzer
    speedcrunch
    spotify
    stow
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    wakeonlan
    websocat
    wev
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kev/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    btop.enable = true;
    emacs.enable = true;
    exa.enable = true;
  #  helix = {
  #    enable = true;
  #    settings = {
  #      theme = "tokyonight";
  #      editor.lsp.display-messages = true;
  #      keys.normal = {
  #        space.space = "file_picker";
  #        space.w = ":w";
  #        space.q = ":q";
  #        esc = [ "collapse_selection" "keep_primary_selection" ];
  #      };
  #    };
  #  };
    fzf.enable = true;
    gitui.enable = true;
    firefox.enable = true;
    kitty = {
      enable = true;
      font.name = "FiraCode Nerd Font";
      font.size = 13;
      shellIntegration.enableFishIntegration = true;
      # Use "kitty +kitten themes" to view available themes
      theme = "Tokyo Night";
    };
    mpv.enable = true;
    ncspot.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;
    bat.enable = true;
  };

  services = {
    gammastep.tray = true;
    network-manager-applet.enable = true;
  };
}
