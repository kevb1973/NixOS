# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./sway.nix
    ];

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
    kernelPackages = pkgs.linuxPackages_latest; 
  };

  networking.hostName = "halcyon"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 2121 ];

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
  #i18n.inputMethod = {
  #  enabled = "ibus";
  #  ibus.engines = with pkgs.ibus-engines; [ typing-booster ];
  #};


  # Change default stop job timeout for systemd (default is 90s)
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
  
  # Auto optimize nix store.
  nix.settings.auto-optimise-store = true;
  
  # Auto discard system generations
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 2d";
  };  

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    libinput.mouse = {
      accelProfile = "flat";
      accelSpeed = "1.2";
#      buttonMapping = "1 8 3 4 5 6 7 2 9";
#      scrollMethod = "button";
#      scrollButton = 3;
    };
    desktopManager = {
      xterm.enable = false;
      gnome.enable = false;
      xfce = {
        enable = true;
        enableXfwm = true;
      };
    };
    displayManager = {
        startx.enable = true; #console login
        #gdm.enable = true;
        #gdm.wayland= true;
        #lightdm.enable = true;
        #sddm.enable = true;
        #lightdm.greeters.slick.enable = true;
        
        #defaultSession = "none+i3";
        #defaultSession = "xfce+i3";
    };
    videoDrivers = [ "amdgpu" ];
    windowManager = {
      i3 = {
        enable = true;
        #package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          jgmenu
          i3-gaps
          i3a
          picom
          dunst
          rofi
          rofi-power-menu
          polybarFull
          unclutter
          pywal
          lxappearance
          numlockx
          playerctl
          libnotify
          xorg.xev
          feh
          xclip
        ];
      };
    };
  };

  # Set theme for QT apps
  qt.platformTheme = "gnome";
  # Enable Fonts
  fonts.fonts = with pkgs; [
    roboto
    font-awesome
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
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvirtd" "input" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-21.4.0" ];
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];

  # == System Packages == #

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs#wget
  environment.systemPackages = with pkgs; [
    (callPackage ./pkgs/clifm { })
    distrobox
    fd
    gitFull
    gnome.zenity
    handlr
    nil
    htop
    jdk
    killall
    libinput
    lua
    mfcl2700dnlpr
    mfcl2700dncupswrapper
    neovim
    nodejs
    nodePackages.bash-language-server
    os-prober
    podman
    python3
    sox
    unar
    unzip
    vifm-full
    virtualenv
    wget
  ];


  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
    fish.enable = true;
    #gpaste.enable = true;
    kdeconnect.enable = true;
    #neovim.defaultEditor = true;
    neovim.vimAlias = true;
    ssh.startAgent = true;
  };

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
  #services.emacs.install = true;
  #services.emacs.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
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