{ pkgs, inputs, ...}:
{
  programs = {
    adb.enable = true;
    command-not-found.enable = false;
    dconf.enable = true;
    ssh.startAgent = false; # Using gnome-keyring due to niri-flake
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
        "nsn --set-cursor" = "nix-search --name % -d";
        "nsp --set-cursor" = "nix-search --program % -d";
        "nsd --set-cursor" = "nix-search --query-string='package_description:(%)' -d";
        "ytm --set-cursor" = "yt-dlp -x --audio-format mp3 %";
        "ytv --set-cursor" = "ytd-video '%'"; #note: had to use script as <= breaks config due to string interpolation
        "rp --set-cursor" = "nix profile remove '%'";
      };
      
      shellAliases = {
      
        cat = "bat"; 
        more = "bat --paging=always"; 
        less = "bat --paging=always";
        checkpkg = "hydra-check --channel unstable --arch x86_64-linux";
        conf = "hx  ~/NixOS/";
        dg = "nh clean user";
        edit-broken = "hx ~/bin/check_broken"; # Edit list of currently broken packages 
        e = "hx";
        find-font = "fc-list --format='%{family}\n' | grep";
        gcroots = "sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'";
        gc = "sudo nix store gc -v";
        g = "gitui";
        lg = "lazygit";
        logout = "sudo systemctl restart display-manager.service";
        logs = "sudo lazyjournal";
        lp = "nix profile list";
        ls = "lsd";
        lu = ''echo -e "\n\e[1mLast Flake Update:\e[0m $(ls -l ~/NixOS/flake.lock | awk '{print $6, $7, $8}')\n"'';
        no = "nixos option -i";
        # no = "nixos option -i";
        npu = "nix profile upgrade";
        opt = "nix-store --optimize";
        ports = "netstat -lntup";
        rb = "nixos-rebuild switch --sudo --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        rd = "cd (fd --type dir --hidden --follow | fzf)"; # search for dirs, change dir
        rf = "cd (fd --type file --hidden --follow | fzf | cut -d/ -f 1-3)"; # search dir for file and change dir
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
      };
      
      # interactiveShellInit = '' # Set Neovim as default man viewer
        # set -x MANPAGER "nvim -c 'Man!'"
      # '';
    };

    # foot = {
    #   enable = true;
    #   enableFishIntegration = true;
    #   theme = "tokyonight-storm";
    #   settings = {
    #     main = {
    #       shell = "/run/current-system/sw/bin/fish";
    #       font = "Victor Mono:size=13";
    #     };
    #     key-bindings = {
    #       scrollback-up-half-page = "Mod1+Up";
    #       scrollback-down-half-page = "Mod1+Down";
    #     };
    #   };
    # };

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
