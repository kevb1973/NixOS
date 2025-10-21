{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    adb.enable = true;
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

      # promptInit = ''
      #   ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      # '';

      shellAbbrs = {
        # "no --set-cursor" = "nixos-option % --flake ~/NixOS";
        "jgc --set-cursor" = "jj git clone --colocate %";
        "nor --set-cursor" = "nixos-option -r % --flake ~/NixOS";
        "npi --set-cursor" = "nix profile install nixpkgs#%";
        "npg --set-cursor" = "nix profile install github:%/";
        "npis --set-cursor" = "nix profile install nixpkgs/release-24.11#%";
        "npic --set-cursor" = "nix profile install nixpkgs/(nixos-version --hash)#%";
        "npu --set-cursor" = "nix profile upgrade %";
        "nr --set-cursor" = "nix run nixpkgs#%";
        "ns --set-cursor" = "nix shell nixpkgs#% -c fish";
        # "nsn --set-cursor" = "nix-search --name % -d";
        # "nsp --set-cursor" = "nix-search --program % -d";
        # "nsd --set-cursor" = "nix-search --query-string='package_description:(%)' -d";
        "scu" = "systemctl --user";
        "sn" = "nh search";
        "ytm --set-cursor" = "yt-dlp -x --audio-format mp3 %";
        "ytv --set-cursor" = "ytd-video '%'"; # note: had to use script as <= breaks config due to string interpolation
        # "rp --set-cursor" = "nix profile remove '%'";
      };

      shellAliases = {
        cat = "bat";
        more = "bat --paging=always";
        less = "bat --paging=always";
        hydra = "hydra-check --channel nixos-unstable --arch x86_64-linux";
        conf = "hx  ~/NixOS/";
        dg = "nh clean user";
        edit-broken = "hx ~/bin/check_broken"; # Edit list of currently broken packages
        e = "hx";
        find-font = "fc-list --format='%{family}\n' | grep";
        gcroots = "sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'";
        gc = "sudo nix store gc -v";
        g = "gitui";
        jn = "cd ~/NixOS; jjui";
        jd = "cd ~/dotfiles; jjui";
        jD = "cd ~/.config/DMS; jjui";
        js = "cd ~/Documents/silverbullet; jjui";
        lg = "lazygit";
        logout = "sudo systemctl restart display-manager.service";
        logs = "sudo lazyjournal";
        lp = "nix profile list";
        ls = "lsd";
        lu = ''echo -e "\n\e[1mLast Flake Update:\e[0m $(ls -l ~/NixOS/flake.lock | awk '{print $4, $5, $6}')\n"'';
        no = "optnix -s nixos";
        np = "tv nix -i nixpkgs ";
        opt = "nix-store --optimize";
        ports = "netstat -lntup";
        # rb = "nixos-rebuild switch --sudo --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        rb = "nh os switch ~/NixOS/";
        referrer = "nix-store --query --referrers";
        repair-store = "sudo nix-store --verify --check-contents --repair";
        rev = "nixos-version --hash | cut -c 1-7";
        sg = "nixos-rebuild list-generations";
        storebin = "nix-store -q --roots (which $argv)";
        ug = "nix-env --list-generations";
        ugc = "nix store gc -v";
        # up = "nh os switch --update --ask ~/NixOS";
        up = "nix flake update --flake /home/kev/NixOS";
        verify-store = "sudo nix-store --verify --check-contents";
        y = "yazi";
        v = "vifm";
        zz = "zi";
        zzz = "cd (fd . -td -tl -H -d2 -c always | fzf --height 50% --color=dark --ansi)"; # search for dirs, change dir
      };
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

    niri = {
      enable = false;
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
