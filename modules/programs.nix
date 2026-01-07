{
  pkgs,
  ...
}:
{
  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
    ssh.startAgent = false; # Using gnome-keyring due to niri-flake
    neovim = {
      vimAlias = true;
    };

    appimage = {
      enable = false;
      # binfmt = true;
    };

    firefox = {
      enable = true;
      # nativeMessagingHosts.packages = [ pkgs.fx-cast-bridge ];
    };

    fish = {
      enable = true;
    };

    fuse = {
      userAllowOther = true;
    };

    fzf = {
      keybindings = false;
      fuzzyCompletion = true;
    };

    # hyprland = {
    #   enable = true;
    #   #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # };

    # mango.enable = true;

    niri = {
      enable = true;
      # package = inputs.niri.packages.${pkgs.system}.default;
    };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add missing dynamic libraries for unpackged programs here.. not systemPackages or user packages.
        alsa-lib
        at-spi2-atk
        at-spi2-core
        atk
        cairo
        cups
        curl
        dbus
        expat
        fontconfig
        freetype
        fuse
        gdk-pixbuf
        glib
        glibc_memusage
        gtk2
        gtk2-x11
        gtk3
        gtk3-x11
        gtk4
        harfbuzz
        icu
        krb5
        libgbm
        libgcc
        libGL
        libappindicator-gtk3
        libdrm
        libedit
        libglvnd
        libnotify
        libpulseaudio
        libsoup_3
        libunwind
        libusb1
        libuuid
        libxkbcommon
        libxml2
        mesa
        ncurses
        nspr
        nss
        openssl
        pango
        pipewire
        # speechd
        stdenv.cc.cc
        systemd
        tree-sitter
        vulkan-loader
        webkitgtk_4_1
        xorg.libX11
        xorg.libXScrnSaver
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXi
        xorg.libXrandr
        xorg.libXrender
        xorg.libXtst
        xorg.libxcb
        xorg.libxkbfile
        xorg.libxshmfence
        xorg.libXinerama
        xorg_sys_opengl
        zlib
      ];
    };

    # sway = {
    #   enable = true;
    #   wrapperFeatures.gtk = true;
    #   extraPackages = [ ];
    # };

    # ydotool = {
    #   enable = true;
    #   group = "users";
    # };
    waybar.enable = false;
  }; # End of programs
}
