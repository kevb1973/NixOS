{ config, pkgs, lib, ...}:
{
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
  }; 
}
