# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, lib, ... }:

{
  imports = [ ./hardware-configuration.nix ./sway.nix ];

  # Hardware Tweaks
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  hardware.opengl.enable = true;
  # Vulcan
  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  #hardware.opengl.extraPackages = with pkgs; [
  #  rocm-opencl-icd
  #  rocm-opencl-runtime
  #];

  # Bootloader.

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
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
        # splashImage = ./backgrounds/grub-nixos-3.png;
        # splashMode = "stretch";
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
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  networking.hostName = "halcyon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 2121 2234 6475 6476 ];
  networking.firewall.allowedUDPPorts = [ 36475 ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
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
    network.wait-online.enable =
      false; # Disable systemd "wait online" as it gets stuck waiting for connection on 2nd NIC
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
    nixPath = [ "/etc/nix/inputs" ]; #Fix <nixpkgs> for flakes. See environment.etc."nix/inputs/nixpkgs"
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs; # Pin nixpkgs to speed up nix commands
    settings.auto-optimise-store = true; # Auto optimize nix store.
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "cage -s -- gtkgreet -l -b /etc/xdg/wallpaper/nix-wallpaper-simple-dark-gray_bottom.png";
        user = "greeter";
      };
    };
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
    "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}"; # needed to fix <nixpkgs> on flake. See also nix.nixPath
  };

  services.xserver = {
    enable = false;
    layout = "us";
    xkbVariant = "";
    libinput.mouse = {
      accelProfile = "flat";
      accelSpeed = "1.2";
      # buttonMapping = "1 8 3 4 5 6 7 2 9";
      # scrollMethod = "button";
      # scrollButton = 3;
    };
    desktopManager = {
      xterm.enable = false;
      gnome.enable = false;
      xfce = {
        enable = false;
        enableXfwm = false;
      };
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
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''Option "TearFree" "true"'';
    windowManager = {
      i3 = {
        enable = false;
        #package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          # dmenu # application launcher most people use
          # i3status # gives you the default i3 status bar
          # i3-gaps
          # i3a
          # picom
          # dunst
          # rofi
          # rofi-power-menu
          # polybarFull
          # unclutter
          # pywal
          lxappearance
          # numlockx
          libnotify
          # xorg.xev
          feh
          # xclip
        ];
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
  # Enable CUPS to print documents
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  #DBus service for accessing list of user a/c and info about them. (needed for clifm)
  services.accounts-daemon.enable = true;
  #Avahi daemon
  #services.avahi.enable = true;
  # Enable Bluetooth Services for Window Managers
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #Enable Flatpak
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  #  sound.enable = true;
  #  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
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

  # Setup podman for distrobox
  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = true;
  virtualisation.libvirtd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # == User Account == #
  users.users.kev = {
    isNormalUser = true;
    description = "kev";
    extraGroups = [ "networkmanager" "adbusers" "wheel" "kvm" "libvirtd" "input" "audio" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      appeditor
      android-tools
      bat
      beebeep
      # broot
      btop
      calibre
      cheat
      cliphist
      emacs29
      emacs-all-the-icons-fonts
      eza
      feh
      firefox-beta
      fzf
      vimPlugins.firenvim
      fishPlugins.tide
      foliate
      gammastep
      gcc
      gnome.gnome-clocks
      gnome.file-roller
      gucharmap
      hyprland
      jgmenu
      jq
      kitty
      lazygit
      logseq
      gnumake
      mplayer
      ncdu
      ncpamixer
      neofetch
      nix-prefetch-git
      nvd
      obsidian
      pamixer
      pavucontrol
      pistol # file preview for clifm
      playerctl
      pulsemixer
      ripgrep
      shadowfox
      sl
      speedcrunch
      stow
      swww
      telegram-desktop
      thunderbird
      virt-manager
      wakeonlan # fro lgtv control
      waybar
      waypaper
      websocat # for lgtv control
      wev
      wtype # for wofi-emoji
      yt-dlp
      zathura

    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.permittedInsecurePackages = [ "electron-21.4.0" ];

  environment.pathsToLink = [ "/libexec" ]; # enable polkit

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs#wget
  environment.systemPackages = with pkgs; [
    (callPackage ./pkgs/clifm { })
    alsa-utils
    anydesk
    archiver
    atool
    bemenu
    cage
    cliphist
    distrobox
    dracula-theme
    fd
    gammastep
    glib
    gitFull
    gnome.adwaita-icon-theme
    gnome.zenity
    grim
    greetd.gtkgreet
    handlr
    helix
    htop
    jdk
    killall
    libinput
    lua
    materia-theme
    mfcl2700dnlpr
    mfcl2700dncupswrapper
    neovim
    nil
    nixfmt
    nodejs
    nodePackages.bash-language-server
    # obsidian
    os-prober
    # podman
    python3
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    slurp
    sox
    #spotify
    #sway
    swaybg
    swayidle
    swaylock
    swaynotificationcenter
    unar
    unzip
    vifm-full
    virtualenv
    waybar
    wayland
    wget
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wofi
    xdg-utils # for openning default programms when clicking links
  ];

  programs = {
    adb.enable = true;
    command-not-found.enable = false;
    dconf.enable = true;
    fish.enable = true;
    #gpaste.enable = true;
    kdeconnect.enable = true;
    #neovim.defaultEditor = true;
    neovim = { vimAlias = true; };
    ssh.startAgent = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

  };

  # Thunar Setup
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services = {
    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
    geoclue2.enable = true;
  };

  services.emacs.enable = false;

  services.freshrss = {
    enable = true;
    baseUrl = "http://freshrss";
    defaultUser = "kev";
    passwordFile = "/run/secrets/freshrss";
    authType = "none";
  };
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
