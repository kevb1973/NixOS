# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ./sway.nix ];

  hardware = {
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
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

  # Bootloader.

  boot = {
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.network.wait-online.enable = false;
    };
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

    tmp.useTmpfs = true;
    kernelModules = [ "amd-pstate" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      #"initcall_blacklist=acpi_cpufreq_init"
      #"amd_pstate=active"
      "nowatchdog"
      "nmi_watchdog=0"
      "quiet"
    ];
    # Below setting needed as system state ver < 23.11
    swraid.enable = false;
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  networking = {
    hostName = "halcyon";
    nameservers = [ "9.9.9.9" "2620:fe::fe" ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.allowedTCPPorts = [ 80 2121 2234 6475 6476 53317 ];
    firewall.allowedUDPPorts = [ 36475 53317 ];
    interfaces.enp42s0.wakeOnLan.enable = true;
    networkmanager = {
      enable = true;
      dns = "none";
    };
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
  };

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Portals for flatpaks etc.
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  systemd = {
    # user.services.polkit-kde-authentication-agent-1 = {
    #   after = [ "graphical-session.target" ];
    #   description = "polkit-kde-authentication-agent-1";
    #   wantedBy = [ "graphical-session.target" ];
    #   wants = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #     TimeoutStopSec = 10;
    #   };
    # };
    # user.services.polkit-gnome-authentication-agent-1 = {
    #   description = "polkit-gnome-authentication-agent-1";
    #   wantedBy = [ "graphical-session.target" ];
    #   wants = [ "graphical-session.target" ];
    #   after = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart =
    #       "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #     TimeoutStopSec = 10;
    #   };
    # };
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
    gc = {
      # Auto discard system generations
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    nixPath = [
      "/etc/nix/inputs"
    ]; # Fix <nixpkgs> for flakes. See environment.etc."nix/inputs/nixpkgs"
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake =
      inputs.nixpkgs; # Pin nixpkgs to speed up nix commands
    settings = {
      auto-optimise-store = true; # Auto optimize nix store.
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };


  environment = {
    etc = {
      # "greetd/environments".text = ''
      #   Hyprland
      #   sway
      #   fish
      # '';
      "xdg/gtk-3.0".source = ./gtk-3.0;
      "xdg/gtk-4.0".source = ./gtk-4.0;
      "xdg/wallpaper".source = ./wallpaper;
      "nix/inputs/nixpkgs".source =
        "${inputs.nixpkgs}"; # needed to fix <nixpkgs> on flake. See also nix.nixPath
    };
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
  };

  services = {

    freshrss = {
      enable = true;
      baseUrl = "http://freshrss";
      defaultUser = "kev";
      passwordFile = "/run/secrets/freshrss";
      authType = "none";
    };

    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };

    # greetd = {
    #   enable = true;
    #   settings = {
    #     default_session = {
    #       command =
    #         "cage -s -- gtkgreet -l -b /etc/xdg/wallpaper/nix-wallpaper-simple-dark-gray_bottom.png";
    #       user = "greeter";
    #     };
    #   };
    # };

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

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      videoDrivers = [ "amdgpu" ];
      deviceSection = ''Option "TearFree" "true"'';

      desktopManager = {
        xterm.enable = false;
        gnome.enable = false;
        xfce = {
          enable = false;
          enableXfwm = false;
        };
      };

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
      displayManager = {
        # startx.enable = true; # console login
        sddm = {
          enable = true;
          theme = "chili";
        };
      };

      windowManager = {
        i3 = {
          enable = false;
          extraPackages = with pkgs; [
            # lxappearance
            # feh
          ];
        };
      };
    };
  };
  # Set theme for QT apps
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };

  # Enable Fonts
  fonts = {
    packages = with pkgs; [
      font-awesome
      noto-fonts-lgc-plus
      noto-fonts-color-emoji
      source-code-pro
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
  # Setup podman for distrobox
  virtualisation = {
    podman.enable = true;
    podman.dockerCompat = true;
    libvirtd.enable = true;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # == User Account == #
  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups =
      [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" ];
    # shell = pkgs.fish;
    packages = with pkgs; [
      # broot
      android-tools
      anydesk
      appeditor
      authenticator
      bat
      beebeep
      btop
      calibre
      cargo
      cava #terminal audio visualizer
      cheat
      clifm
      cliphist
      dracula-theme
      emacs-all-the-icons-fonts
      emacs29
      eza
      fd
      feh
      firefox-beta
      fishPlugins.tide
      foliate #epub reader
      fzf
      gammastep
      gcc
      gnome.file-roller
      gnome.gnome-clocks
      gnumake
      grim
      gucharmap
      jgmenu
      jq
      kitty
      lazygit
      libnotify
      libsForQt5.polkit-kde-agent
      libsForQt5.kalarm
      localsend
      logseq
      mako
      # materia-theme
      mpv
      (mpv.override { scripts = [ mpvScripts.mpris ]; })
      mate.mate-polkit
      ncdu
      ncpamixer
      neovide #nvim gui front end
      nix-prefetch-git
      nvd
      pamixer
      pavucontrol
      pistol # file preview for clifm
      playerctl
      pulsemixer
      qalculate-gtk
      ripgrep
      sddm-chili-theme
      shadowfox
      slurp
      spotify
      stow
      stylua
      swaybg
      swayidle
      swaylock
      syncthing
      tartube # front end for yt-dlp
      telegram-desktop
      thunderbird
      tree-sitter
      virt-manager
      vlc
      wakeonlan # fro lgtv control
      waybar
      waypaper
      websocat # for lgtv control
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wofi
      wtype # for wofi-emoji
      # inputs.yazi.packages.${pkgs.system}.yazi
      yazi
      ydotool
      yt-dlp
      zathura
      zoxide
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];


  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs#wget
  environment = {
    pathsToLink = [ "/libexec" ]; # enable polkit
    systemPackages = with pkgs; [
      alsa-utils
      archiver
      atool
      distrobox
      glib
      gitFull
      gnome.adwaita-icon-theme
      gnome.zenity
      handlr
      htop
      jdk
      killall
      libinput
      libsForQt5.breeze-icons
      libsForQt5.qt5.qtwayland
      libsForQt5.qt5ct
      lua
      mfcl2700dnlpr
      mfcl2700dncupswrapper
      neovim
      nil
      nixfmt
      nodejs
      nodePackages.bash-language-server
      os-prober
      pulseaudioFull
      python3
      qt6.qtwayland
      qt6Packages.qt6ct
      qt6Packages.qtstyleplugin-kvantum
      unar
      unzip
      vifm-full
      virtualenv
      wayland
      xdg-utils # for openning default programms when clicking links
    ];
  };
  programs = {
    #gpaste.enable = true;
    #neovim.defaultEditor = true;
    adb.enable = true;
    command-not-found.enable = false;
    dconf.enable = true;
    fish.enable = true;
    fish.vendor.config.enable = false;

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    kdeconnect.enable = false;
    neovim = { vimAlias = true; };

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    ssh.startAgent = true;
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
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
