{ pkgs, ... }:
{
  services = {
    accounts-daemon.enable = true;
    avahi.enable = true;
    blueman.enable = true;
    dbus.enable = true;
    envfs.enable = true; #fixes script shebangs looking in /usr/bin /bin etc.
    flatpak.enable = true;
    fwupd.enable = false; # disabled.. slowing boot.. no updates available anyways. (fwdupdmgr get-updates)
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    nixos-cli.enable = true;
    openssh.enable = false;
    printing.drivers = [ pkgs.brlaser ];
    printing.enable = false; # disabled due to CUPS Vulernability
    tumbler.enable = false; # Thumbnail support for images

    atd = {
      enable = true; # 'at' daemon for reminders
      allowEveryone = true;
    };
    
    desktopManager = {
      plasma6.enable = false;
      plasma6.enableQt5Integration = true;
      # cosmic.enable = false;
    };

    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "kev";
      # cosmic-greeter.enable = false;
      defaultSession = "niri";
      sddm = {
        enable = false;
        autoNumlock = true;
        theme = "sugar-dark";
        wayland.enable = true;
      };
    };

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
    getty = {
      autologinUser = "kev";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      deviceSection = ''Option "TearFree" "true"'';
      desktopManager = {
        xterm.enable = false;
        gnome.enable = false;
        xfce = {
          enable = false;
          enableXfwm = false;
        };
      };
      displayManager = {
        gdm = {
          enable = false;
          wayland = true;
          autoLogin.delay = 2;
        };
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
