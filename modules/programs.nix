{ pkgs, inputs, ...}:
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
        # "no --set-cursor" = "nixos-option % --flake ~/NixOS";
        "nor --set-cursor" = "nixos-option -r % --flake ~/NixOS";
        "npi --set-cursor" = "nix profile install nixpkgs#%";
        "npg --set-cursor" = "nix profile install github:%/";
        "npis --set-cursor" = "nix profile install nixpkgs/release-24.11#%";
        "npic --set-cursor" = "nix profile install nixpkgs/(nixos-version --hash)#%";
        "ns --set-cursor" = "nix shell nixpkgs#% -c fish";
        "nr --set-cursor" = "nix run nixpkgs#%";
        "np --set-cursor" = "np '%'";
        "ytm --set-cursor" = "yt-dlp -x --audio-format mp3 '%'";
        "ytv --set-cursor" = "ytd-video '%'"; #note: had to use script as <= breaks config due to string interpolation
        "rp --set-cursor" = "nix profile remove '%'";
      };
      
      shellAliases = {
        cat = "bat"; 
        checkpkg = "hydra-check --channel unstable --arch x86_64-linux";
        conf = "hx  ~/NixOS/";
        cpr = "nixos info | grep Nixpkgs | awk -F ' ' '{print $4}' | wl-copy";
        dg = "nh clean all";
        e = "hx";
        edit-broken = "hx ~/bin/check_broken"; # Edit list of currently broken packages 
        gcroots = "sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'";
        g = "gitui";
        less = "bat --paging=always";
        lg = "lazygit";
        logout = "sudo systemctl restart display-manager.service";
        logs = "sudo lazyjournal";
        lp = "nix profile list";
        lu = ''echo -e "\n\e[1mLast Flake Update:\e[0m $(ls -l ~/NixOS/flake.lock | awk '{print $6, $7, $8}')\n"'';
        # no = "nixos option -i";
        no = "manix";
        np = "nh search"; # search nix packages
        npu = "nix profile upgrade";
        opt = "nix-store --optimize";
        ports = "netstat -lntup";
        # rb = "nh os switch ~/NixOS";
        rb = "nixos-rebuild switch --use-remote-sudo --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        referrer = "nix-store --query --referrers";
        repair-store = "sudo nix-store --verify --check-contents --repair";
        rev = "nixos-version --hash | cut -c 1-7";
        # sdg = "sudo nix-collect-garbage -d";
        # sg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        sg = "nixos-rebuild list-generations";
        sgc = "sudo nix store gc -v";
        storebin = "nix-store -q --roots (which $argv)";
        # udg = "nix-collect-garbage -d";
        udg = "nh clean user";
        ug = "nix-env --list-generations";
        ugc = "nix store gc -v";
        # up = "nix flake update /home/kev/NixOS";
        up = "nh os switch --update --ask ~/NixOS";
        verify-store = "sudo nix-store --verify --check-contents";
        y = "yazi";
      };
      
      # interactiveShellInit = '' # Set Neovim as default man viewer
        # set -x MANPAGER "nvim -c 'Man!'"
      # '';
    };

    foot = {
      enable = false;
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

    # hyprland = {
    #   enable = true;
    #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    # };

    niri = {
      enable = true;
      package = pkgs.niri-unstable;
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
          speechd
          stdenv.cc.cc
          systemd
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

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

    ydotool = {
      enable = true;
      group = "users";
    };
    waybar.enable = true;
  }; #End of programs
}
