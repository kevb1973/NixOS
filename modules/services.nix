{ pkgs, lib, ... }:
{
  services = {
    accounts-daemon.enable = true;
    avahi.enable = true;
    blueman.enable = false; # wifi/bluetooth card stopped working..TODO: need to investigate. 
    dbus.enable = true;
    envfs.enable = true; #fixes script shebangs looking in /usr/bin /bin etc.
    flatpak.enable = true;
    fwupd.enable = false; # disabled.. slowing boot.. no updates available anyways. (fwdupdmgr get-updates)
    geoclue2.enable = true;
    # gnome.gnome-keyring.enable = lib.mkDefault false; # using programs.ssh.startAgent, override due to niri-flake
    gvfs.enable = true; # Mount, trash, and other functionalities
    journald.extraConfig = "SystemMaxUse=500M";
    # nixos-cli.enable = true;
    openssh.enable = false;
    printing.drivers = [ pkgs.brlaser ];
    printing.enable = true; 
    tumbler.enable = false; # Thumbnail support for images

    atd = {
      enable = true; # 'at' daemon for reminders
      allowEveryone = true;
    };

    bpftune.enable = true; # Auto tune kernel/network
    
    desktopManager = {
      plasma6.enable = false;
      plasma6.enableQt5Integration = true;
      # cosmic.enable = true;
    };

    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "kev";
      # cosmic-greeter.enable = false;
      defaultSession = "hyprland";
      sddm = {
        enable = false;
        autoNumlock = true;
        theme = "sugar-dark";
        wayland.enable = true;
      };
    };

    emacs = {
       enable = false;
    };

    # freshrss = {
    #   enable = true;
    #   baseUrl = "http://freshrss";
    #   defaultUser = "kev";
    #   passwordFile = "/run/secrets/freshrss";
    #   authType = "none";
    # };

    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
    getty = {
      # autologinUser = "kev";
    };

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome to NixOS' --remember --remember-user-session --time --theme border=cyan;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red --cmd niri-session";
        };
      };
    };

    nixos-cli = {
      enable = true;
      config = {
        config_location = "/home/kev/NixOS";
        use_nvd = true;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    # silverbullet = { # switched to docker version for faster updates 
    #   enable = true;
    #   user = "kev";
    #   openFirewall = true;
    #   listenAddress = "localhost";
    #   listenPort = 8082;
    # };

    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "10.3.0";
      environmentVariables = { HIP_VISIBLE_DEVICES = "1";  ROCR_VISIBLE_DEVICES = "0"; };
      
    };
    
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
      deviceSection = ''Option "TearFree" "true"'';
      displayManager = {
        startx.enable = true; # console login
      };
      #updateDbusEnvironment = true;
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
  }; 
}
