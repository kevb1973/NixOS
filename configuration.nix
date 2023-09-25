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
    firewall.allowedTCPPorts = [ 80 2121 2234 6475 6476 ];
    firewall.allowedUDPPorts = [ 36475 ];
    networkmanager.dns = "none";
    networkmanager.enable = true;
    networkmanager = {
    wireless.enable = false;  # Enables wireless support via wpa_supplicant.
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
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
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
    gc = { # Auto discard system generations
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
    settings.auto-optimise-store = true; # Auto optimize nix store.
  };


  environment.etc = {
    "greetd/environments".text = ''
      Hyprland
      sway
      fish
    '';
    "xdg/gtk-3.0".source = ./gtk-3.0;
    "xdg/gtk-4.0".source = ./gtk-4.0;
    "xdg/wallpaper".source = ./wallpaper;
    "nix/inputs/nixpkgs".source =
      "${inputs.nixpkgs}"; # needed to fix <nixpkgs> on flake. See also nix.nixPath
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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command =
            "cage -s -- gtkgreet -l -b /etc/xdg/wallpaper/nix-wallpaper-simple-dark-gray_bottom.png";
          user = "greeter";
        };
      };
    };

    accounts-daemon.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    geoclue2.enable = true;
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
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    xserver = {
      enable = false;
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

      libinput.mouse = {
        accelProfile = "flat";
        accelSpeed = "1.2";
        # buttonMapping = "1 8 3 4 5 6 7 2 9";
        # scrollMethod = "button";
        # scrollButton = 3;
      };

      displayManager = {
        #startx.enable = true; # console login
        #gdm.enable = true;
        #gdm.wayland= true;
        #lightdm.enable = true;
        #sddm.enable = true;
        #lightdm.greeters.slick.enable = true;
        #defaultSession = "none+i3";
        #defaultSession = "xfce+i3";
      };

      windowManager = {
        i3 = {
          enable = false;
          extraPackages = with pkgs; [
            lxappearance
            feh
          ];
        };
      };
    };
  };
  # Set theme for QT apps
  qt.platformTheme = "gnome";
  # Enable Fonts
  fonts.packages = with pkgs; [
    alegreya
    fira-code
    # noto-fonts
    noto-fonts-emoji
    roboto
    roboto-mono
    font-awesome
    source-code-pro
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  security.rtkit.enable = true;

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
    shell = pkgs.fish;
    packages = with pkgs; [
      # broot
      android-tools
      anydesk
      appeditor
      bat
      beebeep
      bemenu
      btop
      calibre
      cargo
      cheat
      cliphist
      dracula-theme
      emacs-all-the-icons-fonts
      emacs29
      eza
      fd
      feh
      firefox-beta
      fishPlugins.tide
      foliate
      fzf
      gammastep
      gammastep
      gcc
      gnome.file-roller
      gnome.gnome-clocks
      gnumake
      grim
      gucharmap
      hyprland
      jgmenu
      jq
      kitty
      lazygit
      libnotify
      logseq
      mako
      materia-theme
      mplayer
      ncdu
      ncpamixer
      neofetch
      neovide #nvim gui front end
      nix-prefetch-git
      nvd
      obsidian
      pamixer
      pavucontrol
      pistol # file preview for clifm
      playerctl
      pulsemixer
      ripgrep
      scrcpy
      shadowfox
      sl
      slurp
      speedcrunch
      stow
      stylua
      swaybg
      swayidle
      swaylock
      swww
      tartube # front end for yt-dlp
      telegram-desktop
      thunderbird
      tree-sitter
      vimPlugins.firenvim
      virt-manager
      wakeonlan # fro lgtv control
      waybar
      waybar
      waypaper
      websocat # for lgtv control
      wev
      wget
      wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
      wofi
      wtype # for wofi-emoji
      yt-dlp
      zathura
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.permittedInsecurePackages = [ "electron-21.4.0" ];


  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs#wget
  environment = {
    pathsToLink = [ "/libexec" ]; # enable polkit
    systemPackages = with pkgs; [
      (callPackage ./pkgs/clifm { })
      (python310.withPackages(ps: with ps; [pyftpdlib]))
      alsa-utils
      archiver
      atool
      cage
      distrobox
      glib
      gitFull
      gnome.adwaita-icon-theme
      gnome.zenity
      greetd.gtkgreet
      handlr
      helix
      htop
      jdk
      killall
      libinput
      lua
      mfcl2700dnlpr
      mfcl2700dncupswrapper
      neovim
      nil
      nixfmt
      nodejs
      nodePackages.bash-language-server
      os-prober
      python3
      libsForQt5.qt5.qtwayland
      qt6.qtwayland
      sox
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
    kdeconnect.enable = false;
    neovim = { vimAlias = true; };
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
