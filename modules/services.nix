{ pkgs, ... }:
{
  services = {
    accounts-daemon.enable = true;
    avahi.enable = true;
    blueman.enable = false; 
    dbus.enable = true;
    envfs.enable = true; # fixes script shebangs looking in /usr/bin /bin etc.
    flatpak.enable = true;
    fwupd.enable = false; # disabled.. slowing boot.. no updates available anyways. (fwdupdmgr get-updates)
    geoclue2.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    journald.extraConfig = "SystemMaxUse=500M";
    openssh.enable = false;
    printing.drivers = [ pkgs.brlaser ];
    printing.enable = true;
    seatd.enable = true; # For lemur display manager
    # tumbler.enable = false; # Thumbnail support for images
    udisks2.enable = true;

    atd = {
      enable = true; # 'at' daemon for reminders
      allowEveryone = true;
    };

    desktopManager = {
      cosmic.enable = false;
      plasma6.enable = false;
      plasma6.enableQt5Integration = true;
    };

    displayManager = {
      # enable = false; # disable ALL display managers
      # autoLogin.enable = false;
      # autoLogin.user = "kev";
      # gdm.enable = true;
      lemurs = {
        enable = true;
        settings = {
          username_field = {
            remember = true;
            style = {
              show_title = true;
              title = "NixOS Halcyon";
              title_color_focused = "light blue";
              content_color_focused = "light blue";
            };
          };
          focus_behaviour = "password";
          background = {
            show_background = true;
            style = {
              color = "black";
              hint_color = "white";

              show_border = true;
              border_color = "dark gray";
            };
          };
          environment_switcher = {
            toggle_hint_color = "white";
            mover_color = "white";
            mover_color_focused = "light blue";
            neighbour_color = "white";
          };
        };
      };
      sddm = {
        enable = false;
        autoNumlock = true;
        theme = "catppuccin-mocha-lavender";
        extraPackages = with pkgs; [
          qt6.qt5compat
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
        ];
        wayland.enable = true;
      };
    };

    emacs = {
      enable = false;
    };

    fstrim = {
      enable = true;
      interval = "weekly"; # the default
    };
    getty = {
      # autologinUser = "kev";
    };

    miniflux = {
      enable = true;
      adminCredentialsFile = "/etc/nixos/miniflux-admin-credentials";
      config.LISTEN_ADDR = "localhost:3002";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    nginx.virtualHosts."localhost".listen = [
      {
        addr = "0.0.0.0";
        port = 3001;
      }
    ];

    udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    ''; # add user perms to uinput for ydotool

    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      desktopManager.xfce.enable = false;
      deviceSection = ''Option "TearFree" "true"'';
      displayManager = {
        startx.enable = false; # console login
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
