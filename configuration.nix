{ pkgs, inputs, lib, ... }:

# --- MISC{{{1
{
 imports = [ ./hardware-configuration.nix ./sway.nix ];
 time.timeZone = "America/Toronto";
 i18n.defaultLocale = "en_CA.UTF-8";
 system.stateVersion = "22.11"; # Don't change unless fresh install from new ISO
  # --- HARDWARE{{{1
  hardware = {
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    # --- OPENGL{{{2
    opengl = {
      enable = true;
      # Vulcan
      driSupport = true;
      driSupport32Bit = true;
      #extraPackages = with pkgs; [
      #  rocm-opencl-icd
      #  rocm-opencl-runtime
      #];
    };
  };
  # --- BOOT --- {{{1
  boot = {
    extraModprobeConfig = ''
      options kvm ignore_msrs=1
    '';
    tmp.useTmpfs = true;
    kernelModules = [ "amd-pstate" ];
    kernelPackages = pkgs.linuxPackages_latest;
    swraid.enable = false; # Setting needed as system state ver < 23.11
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.network.wait-online.enable = false;
    };
    # --- BOOT LOADER --- {{{2
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
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
      "nowatchdog"
      "nmi_watchdog=0"
      "quiet"
      "amd_iommu=on"
      "iommu=pt"
    ];
  };
  # --- POWER MGMT{{{1
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };
  # --- NETWORKING{{{1
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
  # --- XDG{{{1
  xdg = {
    # --- Portals{{{2
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
    # --- Mime Types{{{2
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "vivaldi-stable.desktop";
        "application/x-extension-html" = "vivaldi-stable.desktop";
        "application/x-extension-shtml" = "vivaldi-stable.desktop";
        "application/x-extension-xht" = "vivaldi-stable.desktop";
        "application/x-extension-xhtml" = "vivaldi-stable.desktop";
        "application/x-shellscript" = "lvim.desktop";
        "application/xhtml+xml" = "vivaldi-stable.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "lvim.desktop";
        "text/css" = "lvim.desktop";
        "text/html" = "vivaldi-stable.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "lvim.desktop";
        "video/*" = "umpv.desktop";
        "x-scheme-handler/chrome" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";
      };
    };
  };
  # --- SYSTEMD{{{1
  systemd = {
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    network.wait-online.enable = false; # Disable systemd "wait online" as it gets stuck waiting for connection on 2nd NIC
    services.NetworkManager-wait-online.enable = false;
  };
  # --- NIX{{{1
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    package = pkgs.nixFlakes;
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
  # --- ENVIRONMENT{{{1
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
      GTK_IM_MODULE = "ibus";
      NIX_ALLOW_UNFREE = "1";
      QT_IM_MODULE = "ibus";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      XMODIFIERS = "@im=ibus";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
    # --- SYSTEM PACKAGES{{{1
    systemPackages = with pkgs; [
      alsa-utils
      any-nix-shell
      archiver
      atool
      glib
      gitFull
      gnome.adwaita-icon-theme
      jdk
      killall
      libinput
      libcxxStdenv # Needed to build binaries for tree-sitter
      libsForQt5.breeze-icons
      libsForQt5.qt5ct
      lua
      lua-language-server
      mfcl2700dnlpr
      mfcl2700dncupswrapper
      neovim
      nil
      nixd
      nixfmt
      nodejs
      nodePackages.bash-language-server
      os-prober
      pulseaudioFull
      python3
      sddm-chili-theme
      unar
      unzip
      xdg-utils # for openning default programms when clicking links
    ];
  };
  # --- SERVICES{{{1
  services = {
    accounts-daemon.enable = true;
    blueman.enable = true;
    dbus.enable = true;
    flatpak.enable = true;
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    openssh.enable = false;
    printing.drivers = [ pkgs.brlaser ];
    printing.enable = true;
    tumbler.enable = true; # Thumbnail support for images
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
      videoDrivers = [ "amdgpu" ];
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
      # --- DISPLAY MANAGER{{{3
      displayManager = {
        # startx.enable = true; # console login
        sddm = {
          enable = true;
          theme = "chili";
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
  # --- QT{{{1
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };
  # --- FONTS{{{1
  fonts = {
    packages = with pkgs; [
      font-awesome
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      source-code-pro
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
  # --- SECURITY{{{1
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
  # --- VIRTUALIZATION{{{1
  virtualisation = {
    podman.enable = true;
    podman.dockerCompat = true;
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        runAsRoot = true;
      };
    };
  };
  # --- USER SETTINGS{{{1
  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups =
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" ];
    shell = pkgs.fish;
    # --- USER PACKAGES{{{1
    packages = with pkgs; [
      # android-tools
      anydesk
      appeditor
      archiver
      authenticator
      bat
      beebeep
      bitwarden
      btop
      calibre
      cargo
      cava # Terminal audio visualizer
      clifm
      cliphist
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
      fuzzel # Launcher
      fzf
      gammastep
      # gcc
      gdu # Disk space analyzer
      gnome.file-roller
      gnome.gnome-clocks
      # gnumake
      grc # generic text colourizer. Using with fishPlugins.grc
      grim
      grimblast # Wrapper for grim/slurp
      gucharmap
      helix
      http-server # Simple http server. Using with surfingkeys config.
      jc # Convert output to json for many utils. Useful with Nushell
      jgmenu
      jq
      kitty
      lazygit
      libnotify
      libsForQt5.polkit-kde-agent
      libsForQt5.kalarm
      # localsend
      logseq
      lunarvim
      mako
      marksman # Language server for markdown.
      mediainfo # Provides info on media files. 
      (mpv.override { scripts = [ mpvScripts.mpris mpvScripts.sponsorblock mpvScripts.visualizer ]; })
      mpv-shim-default-shaders
      ncdu
      ncpamixer
      neovide # Nvim gui front end
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
      stow
      stylua
      swaybg
      swayidle
      swaylock
      syncthing
      tartube # Front end for yt-dlp
      tealdeer # Command line help 'tldr'
      thunderbird
      nodePackages.tiddlywiki
      tree-sitter
      virt-manager
      vivaldi
      vlc
      wakeonlan # For lgtv control
      waybar
      waypaper
      websocat # For lgtv control
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
  # --- PROGRAMS{{{1
  programs = {
    # --- Misc{{{2
    adb.enable = true;
    command-not-found.enable = false;
    dconf.enable = true;
    ssh.startAgent = true;
    kdeconnect.enable = false;
    neovim = { vimAlias = true; };
    # --- Firefox{{{2
    firefox = {
      enable = true;
      nativeMessagingHosts.packages = [ pkgs.tridactyl-native];
    };
    # --- Fish{{{2
    fish = {
      enable = true;
      # vendor.config.enable = false;
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
      shellAbbrs = {
        "npi --set-cursor" = "nix profile install nixpkgs#%";
        "ns --set-cursor" = "nix shell nixpkgs#%";
        "nr --set-cursor" = "nix run nixpkgs#%";
      };
      shellAliases = {
        cat = "bat";
        conf = "neovide  ~/NixOS/configuration.nix";
        e = "lvim";
        ee = "neovide --neovim-bin lvim";
        gcroots = "sudo nix-store --gc --print-roots | grep -Ev '^(/proc|/nix|/run)'";
        lg = "lazygit";
        lp = "nix profile list | grep -E 'Flake attribute|Index'";
        rb = "sudo nixos-rebuild switch --flake '/home/kev/NixOS#halcyon' && nix flake archive /home/kev/NixOS && /home/kev/bin/sysdiff";
        referrer = "nix-store --query --referrers";
        repair-store = "sudo nix-store --verify --check-contents --repair";
        rp = "nix profile remove ";
        sdg = "sudo nix-collect-garbage -d";
        sg = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        sgc = "sudo nix store gc -v";
        storebin = "nix-store -q --roots (which $argv)";
        sys = "sudo du -hs /nix/store/ /var/";
        udg = "nix-collect-garbage -d";
        ug = "nix-env --list-generations";
        ugc = "nix store gc -v";
        up = "nix flake update --flake /home/kev/NixOS";
        uup = "nix profile upgrade '.*'";
        verify-store = "sudo nix-store --verify --check-contents";
      };
      interactiveShellInit = '' # Set Neovim as default man viewer
        set -x MANPAGER "nvim -c 'Man!'"
      '';
    };
    # --- FZF{{{2
    fzf = {
      keybindings = false;
      fuzzyCompletion = false;
    };
    # --- Hyprland{{{2
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
    # --- Nix-Index{{{2
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    # --- Nix-ld{{{2
    nix-ld = {
      enable = true;
        libraries = with pkgs; [
          # Add missing dynamic libraries for unpackged programs here.. not systemPackages or user packages.
          gtk3
        ];
    };
    # --- Sway{{{2
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    # --- Thunar{{{2
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
  # --- NIXPKGS{{{1
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [ "electron-25.9.0" ];
  };
}
