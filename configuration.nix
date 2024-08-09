{ pkgs, inputs, lib, ... }:

{
 imports = [ ./hardware-configuration.nix ];
 time.timeZone = "America/Toronto";
 i18n.defaultLocale = "en_CA.UTF-8";

system = {
  stateVersion = "22.11"; # Don't change unless fresh install from new ISO
};

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        # rocmPackages.clr.icd
        # rocmPackages.rocm-smi
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
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
    # nameservers = [ "9.9.9.9" "2620:fe::fe" ];
    # dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.allowedTCPPorts = [ 80 8080 2121 2234 6475 6476 11434 53317 ];
    firewall.allowedUDPPorts = [ 11434 36475 53317 ];
    # interfaces.enp42s0.wakeOnLan.enable = true;
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      # dns = "none";
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
    services = {
      NetworkManager-wait-online.enable = false;
    };
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
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
    optimise.automatic = true; #Auto optimize once per day at 3:45am (default)
    settings = {
      auto-optimise-store = false; # Auto optimize nix store (disabled due to slowing down rebuilds).
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
    sessionVariables = {
      HSA_OVERRIDE_GFX_VERSION="10.3.0";
    };
    variables = {
      # NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland (Logseq doesn't like it.. slow start, crashy)
      ALTERNATE_EDITOR = ""; #allow emacsclient to start daemon if not already running
      AMD_VULKAN_ICD = "RADV";
      CLUTTER_BACKEND = "wayland";
      EDITOR = "emacsclient -r";
      # GDK_BACKEND = "wayland,x11";
      GTK_IM_MODULE = "ibus";
      GTK_THEME="Adwaita:dark";
      HSA_OVERRIDE_GFX_VERSION="10.3.0";
      NIX_ALLOW_UNFREE = "1";
      # OLLAMA_HOST = "0.0.0.0:11434";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_IM_MODULE = "ibus";
      QT_QPA_PLATFORM = "wayland;xcb";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt"; #Needed for X-Plane "AutoOrtho"
      VISUAL = "emacsclient -r";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      XMODIFIERS = "@im=ibus";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    systemPackages = with pkgs; [
      alsa-utils
      any-nix-shell
      archiver
      atool
      blender-hip
      cmake
      desktop-file-utils
      glib
      gitFull
      adwaita-icon-theme
      gnumake
      # hyprlandPlugins.hycov
      jdk
      killall
      libcxxStdenv # Needed to build binaries for tree-sitter
      libinput
      libtool
      # libsForQt5.breeze-icons
      # libsForQt5.qt5ct
      lua
      # lua-language-server
      mfcl2700dnlpr
      mfcl2700dncupswrapper
      neovim
      nil
      # niri
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
    blueman.enable = true;
    dbus.enable = true;
    envfs.enable = true; #fixes script shebangs looking in /usr/bin /bin etc.
    flatpak.enable = true;
    fwupd.enable = true;
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
      plasma6.enableQt5Integration = true;
    };

    # --- DISPLAY MANAGER{{{2
    displayManager = {
      # startx.enable = true; # console login
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        # theme = "where-is-my-sddm-theme";
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
      jack.enable = false;
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
          enable = true;
          enableXfwm = true;
        };
      };
      #updateDbusEnvironment = true;
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
      #windowManager = {
      #  i3 = {
      #    enable = false;
      #    extraPackages = [
      #      # lxappearance
      #      # feh
      #    ];
      #  };
      #};
    }; #end services

  # qt = {
  #   enable = true;
  #   platformTheme = "qt5ct";
  #   style = "kvantum";
  # };

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
    # oci-containers = {
    #   backend = "podman";
    #   containers = {
    #     open-webui = import ./containers/open-webui.nix;
    #   };
    # };
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
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" "podman" "docker" "jackaudio" "mpd" ];
    # shell = pkgs.fish;

    packages = with pkgs; [
      alacritty
      # android-tools
      # anydesk
      appeditor
      arc-theme
      archiver
      audacious
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
      clinfo
      ddcutil # Adjust monitor brightness and other settings from cli
      diff-so-fancy
      discord
      distrobox
      # docker
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
      # gnome-extension-manager
      # gnome.gnome-tweaks
      file-roller
      # gnome.gnome-clocks
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
      # neovide # Nvim gui front end
      nh # nix helper
      nix-prefetch-git
      nix-search-cli
      nvd # Nix derivation diff tool
      okular
      # oterm
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
      # thunderbird
      treesheets
      ueberzugpp
      # nodePackages.tiddlywiki
      tree-sitter
      virt-manager
      # vivaldi #like it, but had issues with page losing keyboard focus.
      # vivaldi-ffmpeg-codecs
      vlc
      wakeonlan # For lgtv control
      # waybar
      inputs.waybar.packages.${pkgs.system}.waybar
      # inputs.nixpkgs-trunk.legacyPackages.${pkgs.system}.waybar

      waypaper
      websocat # For lgtv control
      wttrbar
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wlogout
      # wofi
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
      # --- Prompt{{{3
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      # --- Abbr{{{3
      shellAbbrs = {
        "npi --set-cursor" = "nix profile install nixpkgs#%";
        "ns --set-cursor" = "nix shell nixpkgs#%";
        "nr --set-cursor" = "nix run nixpkgs#%";
        "np --set-cursor" = "np '%'";
        "ytm --set-cursor" = "yt-dlp -x --audio-format mp3 '%'";
        "ytv --set-cursor" = "ytd-video '%'"; #note: had to use script as <= breaks config due to string interpolation
        "rp --set-cursor" = "nix profile remove '%'";
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
        logout = "sudo systemctl restart display-manager.service";
        lp = "nix profile list | grep -E 'Name|Store'";
        lu = ''echo -e "\n\e[1mLast System Update:\e[0m $(ls -l ~/NixOS/flake.lock | awk '{print $6, $7, $8}')\n"'';
        np = "nh search"; # search nix packages
        opt = "nix-store --optimize";
        rb = "nh os switch ~/NixOS";
        # rb = "sudo nixos-rebuild switch --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        referrer = "nix-store --query --referrers";
        repair-store = "sudo nix-store --verify --check-contents --repair";
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
      # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
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
  }; #End of programs

  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = false;
    # permittedInsecurePackages = [ "electron-25.9.0" ];
    };
    overlays = [(final: prev: {
        # rofi-calc = prev.rofi-calc.override { rofi-unwrapped = prev.rofi-wayland-unwrapped; };
      }
    )];
  };
} #End of configuration.nix
