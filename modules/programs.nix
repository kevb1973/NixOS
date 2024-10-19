{ pkgs, ...}:
{
  programs = {
    adb.enable = true;
    command-not-found.enable = false;
    dconf.enable = true;
    ssh.startAgent = true;
    neovim = { vimAlias = true; };

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
      
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      
      shellAbbrs = {
        "npi --set-cursor" = "nix profile install nixpkgs#%";
        "npis --set-cursor" = "nix profile install nixpkgs/release-24.05#%";
        "ns --set-cursor" = "nix shell nixpkgs#%";
        "nr --set-cursor" = "nix run nixpkgs#%";
        "np --set-cursor" = "np '%'";
        "ytm --set-cursor" = "yt-dlp -x --audio-format mp3 '%'";
        "ytv --set-cursor" = "ytd-video '%'"; #note: had to use script as <= breaks config due to string interpolation
        "rp --set-cursor" = "nix profile remove '%'";
      };
      
      shellAliases = {
        cat = "see"; 
        checkpkg = "hydra-check --channel unstable --short -arch x86_64";
        conf = "hx  ~/NixOS/";
        dg = "nh clean all";
        e = "hx";
        edit-broken = "hx ~/bin/check_broken"; # Edit list of currently broken packages 
        gcroots = "sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'";
        lg = "lazygit";
        logout = "sudo systemctl restart display-manager.service";
        lp = "nix profile list | grep -E 'Name|Store'";
        lu = ''echo -e "\n\e[1mLast Flake Update:\e[0m $(ls -l ~/NixOS/flake.lock | awk '{print $6, $7, $8}')\n"'';
        no = "nixos option -i";
        np = "nh search"; # search nix packages
        opt = "nix-store --optimize";
        rb = "nh os switch ~/NixOS";
        # rb = "nixos-rebuild switch --use-remote-sudo --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        referrer = "nix-store --query --referrers";
        repair-store = "sudo nix-store --verify --check-contents --repair";
        # sdg = "sudo nix-collect-garbage -d";
        sg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        sgc = "sudo nix store gc -v";
        storebin = "nix-store -q --roots (which $argv)";
        # sys = "sudo du -hs /nix/store/ /var/"; #replaced with a script that uses dust for speed.
        # udg = "nix-collect-garbage -d";
        udg = "nh clean user";
        ug = "nix-env --list-generations";
        ugc = "nix store gc -v";
        # up = "nix flake update /home/kev/NixOS";
        up = "nh os switch --update --ask ~/NixOS";
        uup = "nix profile upgrade '.*'";
        verify-store = "sudo nix-store --verify --check-contents";
        y = "yazi";
      };
      
      interactiveShellInit = '' # Set Neovim as default man viewer
        set -x MANPAGER "nvim -c 'Man!'"
      '';
    };

    foot = {
      enable = true;
      enableFishIntegration = true;
      theme = "tokyonight-storm";
      settings = {
        main = {
          shell = "/run/current-system/sw/bin/fish";
          font = "Victor Mono:size=13";
        };
        key-bindings = {
          scrollback-up-half-page = "Mod1+Up";
          scrollback-down-half-page = "Mod1+Down";
        };
      };
    };

    fuse = {
      userAllowOther = true;
    };

    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    hyprland = {
      enable = false;
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    # niri = {
    #   enable = true;
    # };

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
          libgcc
          libGL
          libappindicator-gtk3
          libdrm
          libedit
          libglvnd
          libnotify
          libpulseaudio
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
          speechd
          stdenv.cc.cc
          systemd
          vulkan-loader
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

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    ydotool = {
      enable = true;
      group = "users";
    };
  }; #End of programs
}
