{ pkgs, inputs, lib, ... }:

{
 imports = [ ./hardware-configuration.nix ];
 time.timeZone = "America/Toronto";
 i18n.defaultLocale = "en_CA.UTF-8";
 system.stateVersion = "22.11"; # Don't change unless fresh install from new ISO

  hardware = {
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      # Vulcan
      driSupport = true;
      driSupport32Bit = true;
      # extraPackages = with pkgs; [
        # amdvlk
        # rocm-opencl-icd
        # rocm-opencl-runtime
      # ];
    };
  };

  boot = {
    extraModprobeConfig = ''
      options kvm ignore_msrs=1
    '';
    tmp.useTmpfs = true;
    # kernelModules = [ "amd-pstate" ];
    kernelPackages = pkgs.linuxPackages_latest;
    swraid.enable = false; # Setting needed as system state ver < 23.11
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.network.wait-online.enable = false;
    };
    # --- BOOT LOADER --- {{{2
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = false;
        copyKernels = true;
        efiSupport = true;
        devices = [ "nodev" ];
        useOSProber = true;
      };
    };
    # --- KERNEL PARAMS --- {{{2
    kernelParams = [
      #"initcall_blacklist=acpi_cpufreq_init"
      #"amd_pstate=active"
      # "nowatchdog"
      # "nmi_watchdog=0"
      "quiet"
      # "amd_iommu=on"
      # "iommu=pt"
    ];
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  networking = {
    hostName = "halcyon";
    nameservers = [ "9.9.9.9" "2620:fe::fe" ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.allowedTCPPorts = [ 80 8080 2121 2234 6475 6476 53317 ];
    firewall.allowedUDPPorts = [ 36475 53317 ];
    interfaces.enp42s0.wakeOnLan.enable = true;
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      dns = "none";
    };
  };

  xdg = {
    # --- Portals{{{2
    portal = {
      enable = true;
       # extraPortals = with pkgs; [
         # xdg-desktop-portal-wlr
         # xdg-desktop-portal-gtk
       # ];
    };
    # --- Mime Types{{{2
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-shellscript" = "emacsclient.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "emacsclient.desktop";
        "text/css" = "emacsclient.desktop";
        "text/html" = "firefox.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "emacsclient.desktop";
        "video/*" = "umpv.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mpv" = "open-in-mpv.desktop";
      };
    };
  };

  systemd = {
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    network.wait-online.enable = false; # Disable systemd "wait online" as it gets stuck waiting for connection on 2nd NIC
    services.NetworkManager-wait-online.enable = false;
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs; # Pin nixpkgs to speed up nix commands
    gc = {
      # Auto discard system generations
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    nixPath = [
      "/etc/nix/inputs"
    ]; # Fix <nixpkgs> for flakes. See environment.etc."nix/inputs/nixpkgs"
    settings = {
      auto-optimise-store = true; # Auto optimize nix store.
      builders-use-substitutes = true;
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  environment = {
    pathsToLink = [ "/libexec" ]; # enable polkit
    # --- ETC{{{2
    etc = {
      "xdg/gtk-3.0".source = ./gtk-3.0;
      "xdg/gtk-4.0".source = ./gtk-4.0;
      "xdg/wallpaper".source = ./wallpaper;
      "nix/inputs/nixpkgs".source =
        "${inputs.nixpkgs}"; # needed to fix <nixpkgs> on flake. See also nix.nixPath
    };
    # --- ENV VARIABLES{{{2
    variables = {
      # NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland (Logseq doesn't like it.. slow start, crashy)
      ALTERNATE_EDITOR = ""; #allow emacsclient to start daemon if not already running
      CLUTTER_BACKEND = "wayland";
      EDITOR = "emacsclient -r";
      GDK_BACKEND = "wayland,x11";
      GTK_IM_MODULE = "ibus";
      NIX_ALLOW_UNFREE = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_IM_MODULE = "ibus";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt"; #Needed for X-Plane "AutoOrtho"
      VISUAL = "emacsclient -r";
      XMODIFIERS = "@im=ibus";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    systemPackages = with pkgs; [
      alsa-utils
      any-nix-shell
      archiver
      atool
      catppuccin-sddm-corners
      cmake
      glib
      gitFull
      gnome.adwaita-icon-theme
      gnumake
      jdk
      killall
      libcxxStdenv # Needed to build binaries for tree-sitter
      libinput
      libtool
      # libsForQt5.breeze-icons
      # libsForQt5.qt5ct
      lua
      lua-language-server
      mfcl2700dnlpr
      mfcl2700dncupswrapper
      neovim
      nil
      nixfmt-rfc-style
      nodejs
      nix-tree # Explore package dependencies
      nodePackages.bash-language-server
      os-prober
      pulseaudioFull
      python3
      sddm-chili-theme
      unar
      unzip
      usbutils
      xdg-utils # for openning default programms when clicking links
    ];
  };

  services = {
    accounts-daemon.enable = true;
    avahi.enable = true;
    blueman.enable = false;
    dbus.enable = true;
    flatpak.enable = true;
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    openssh.enable = false;
    printing.drivers = [ pkgs.brlaser ];
    printing.enable = true;
    tumbler.enable = true; # Thumbnail support for images
    # --- DESKTOPMANAGER.PLASMA6{{{2
    desktopManager = {
      plasma6.enable = false;
    };
    # --- DISPLAY MANAGER{{{2
    displayManager = {
      # startx.enable = true; # console login
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        theme = "catppuccin-sddm-corners";
        wayland.enable = true;
      };
    };
    # --- FRESH-RSS{{{2
    freshrss = {
      enable = true;
      baseUrl = "http://freshrss";
      defaultUser = "kev";
      passwordFile = "/run/secrets/freshrss";
      authType = "none";
    };
    # --- FSTRIM{{{2
    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
    # --- PIPEWIRE{{{2
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    # --- XSERVER{{{2
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      deviceSection = ''Option "TearFree" "true"'';
      # --- DESKTOP MANAGER{{{3
      desktopManager = {
        xterm.enable = false;
        gnome.enable = false;
        xfce = {
          enable = false;
          enableXfwm = false;
        };
      };
      # --- LIBINPUT{{{3
      libinput = {
        enable = true;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "1.2";
          # buttonMapping = "1 8 3 4 5 6 7 2 9";
          # scrollMethod = "button";
          # scrollButton = 3;
        };
      };
      # --- WINDOW MANAGER{{{3
      windowManager = {
        i3 = {
          enable = false;
          extraPackages = [
            # lxappearance
            # feh
          ];
        };
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  fonts = {
    # fontDir.enable = true;
    packages = with pkgs; [
      font-awesome
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      source-code-pro
      victor-mono
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = [ "kev" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  virtualisation = {
    docker = {
      enable = false;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        runAsRoot = true;
      };
    };
  };

  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups =
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" "podman" "docker" ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      alacritty
      # android-tools
      # anydesk
      appeditor
      arc-theme
      archiver
      authenticator
      bat
      # bitwarden
      btop
      cacert
      calibre
      cargo
      cava # Terminal audio visualizer
      celestia
      clifm
      cliphist
      diff-so-fancy
      discord
      distrobox
      # docker
      dracula-theme
      emacs
      emacsPackages.all-the-icons-nerd-fonts
      eza
      fd
      feh
      fishPlugins.tide
      fishPlugins.puffer
      fishPlugins.grc
      fishPlugins.fzf
      fishPlugins.autopair
      foliate
      fuzzel # Launcher
      fzf
      gammastep
      gdu # Disk space analyzer
      gnome-extension-manager
      gnome.gnome-tweaks
      gnome.file-roller
      gnome.gnome-clocks
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      gucharmap
      helix
      http-server # Simple http server. Using with surfingkeys config.
      hyprpicker
      hyprshade
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast # Wrapper for grim/slurp. . Using flake as nixpkgs ver pulls in old hyprland
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
      # logseq
      # lunarvim
      mako
      marksman # Language server for markdown.
      mediainfo # Provides info on media files.
      meld
      (mpv.override { scripts = [ mpvScripts.mpris mpvScripts.sponsorblock mpvScripts.visualizer ]; })
      mpv-shim-default-shaders
      ncdu
      ncpamixer
      neovide # Nvim gui front end
      nh # nix helper
      nix-prefetch-git
      nix-search-cli
      nushell
      nvd # Nix derivation diff tool
      pamixer
      pavucontrol
      pistol # File preview for clifm
      playerctl
      qalculate-gtk
      qmplay2
      ripgrep
      scrcpy
      slurp
      spotify
      steam-run
      stellarium
      stow
      stylua
      swaybg
      swayidle
      swaylock
      syncthing
      tartube # Front end for yt-dlp
      tealdeer # Command line help 'tldr'
      thunderbird
      treesheets
      ueberzugpp
      nodePackages.tiddlywiki
      tree-sitter
      virt-manager
      # vivaldi
      # vivaldi-ffmpeg-codecs
      vlc
      wakeonlan # For lgtv control

      waybar
      # inputs.nixpkgs-trunk.legacyPackages.${pkgs.system}.waybar

      waypaper
      websocat # For lgtv control
      wttrbar
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wofi
      wtype # For wofi-emoji
      yad
      yazi
      ydotool
      yt-dlp
      zathura
      zoxide
    ];
  };

  programs = {
    adb.enable = true;
    command-not-found.enable = false;
    dconf.enable = true;
    ssh.startAgent = true;
    neovim = { vimAlias = true; };

    firefox = {
      enable = true;
      # nativeMessagingHosts.packages = [ pkgs.fx-cast-bridge ];
    };

    fish = {
      enable = true;
      # --- Prompt{{{3
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      # --- Abbr{{{3
      shellAbbrs = {
        "npi --set-cursor" = "nix profile install nixpkgs#%";
        "ns --set-cursor" = "nix shell nixpkgs#%";
        "nr --set-cursor" = "nix run nixpkgs#%";
      };
      # --- Aliases{{{3
      shellAliases = {
        cat = "bat";
        conf = "emacsclient -r  ~/NixOS/configuration.org";
        dg = "nh clean all";
        e = "emacsclient -nw";
        ee = "emacsclient -r";
        gcroots = "sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'";
        lg = "lazygit";
        lp = "nix profile list | grep -E 'Flake attribute|Index'";
        np = "nh search"; # search nix packages
        # rb = "sudo nixos-rebuild switch --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        rb = "nh os switch ~/NixOS";
        referrer = "nix-store --query --referrers";
        repair-store = "sudo nix-store --verify --check-contents --repair";
        rp = "nix profile remove ";
        # sdg = "sudo nix-collect-garbage -d";
        sg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        sgc = "sudo nix store gc -v";
        storebin = "nix-store -q --roots (which $argv)";
        sys = "sudo du -hs /nix/store/ /var/";
        # udg = "nix-collect-garbage -d";
        udg = "nh clean user";
        ug = "nix-env --list-generations";
        ugc = "nix store gc -v";
        # up = "nix flake update /home/kev/NixOS";
        up = "nh os switch --update --ask ~/NixOS";
        uup = "nix profile upgrade '.*'";
        verify-store = "sudo nix-store --verify --check-contents";
      };
      # --- Interactive Shell Init{{{3
      interactiveShellInit = '' # Set Neovim as default man viewer
        set -x MANPAGER "nvim -c 'Man!'"
      '';
    };

    fuse = {
      userAllowOther = true;
    };

    fzf = {
      keybindings = true;
      fuzzyCompletion = true;
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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
          fuse3
          gdk-pixbuf
          glib
          gtk2
          gtk2-x11
          gtk3
          gtk3-x11
          gtk4
          harfbuzz
          icu
          krb5
          libGL
          libappindicator-gtk3
          libdrm
          libglvnd
          libnotify
          libpulseaudio
          libunwind
          libusb1
          libuuid
          libxkbcommon
          libxml2
          mesa
          nspr
          nss
          openssl
          pango
          pipewire
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
  }; #End of programs

  nixpkgs.config = {
    allowUnfree = true;
    # permittedInsecurePackages = [ "electron-25.9.0" ];
  };
} #End of configuration.nix
