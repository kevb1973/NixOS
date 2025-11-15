{ pkgs, inputs, ... }:
{
  environment = {
    pathsToLink = [ "/libexec" ]; # enable polkit
    etc = {
      "lemurs/wayland/Niri" = {
        mode = "755";
        text = ''
          #!/usr/bin/env sh
          exec niri-session
        '';
      };
      "lemurs/wayland/Mango" = {
        mode = "755";
        text = ''
          #!/usr/bin/env sh
          exec mango
        '';
      };
      "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}"; # needed to fix <nixpkgs> on flake. See also nix.nixPath
    };
    sessionVariables = {
      # HSA_OVERRIDE_GFX_VERSION="10.3.0";
    };
    variables = {
      ALTERNATE_EDITOR = ""; #allow emacsclient to start daemon if not already running
      AMD_VULKAN_ICD = "RADV";
      BAT_STYLE = "header";
      BEMENU_OPTS = "--hf '#5e81ac' --tf '#5e81ac' --fn 'mono 30'";
      CLUTTER_BACKEND = "wayland";
      EDITOR = "hx";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      # GDK_BACKEND = "wayland,x11";
      GTK_IM_MODULE = "ibus";
      # GTK_THEME="Adwaita:light";
      GTK_THEME="adw-gtk3";
      MANPAGER = "nvim +Man!";
      MANWIDTH = "100";
      NIX_ALLOW_UNFREE = "1";
      NIXOS_CONFIG = "/home/kev/NixOS";
      NIX_PAGER = "bat"; 
      # OLLAMA_HOST = "127.0.0.1:11434";
      # OLLAMA_FLASH_ATTENTION = "1";
      PAGER = "bat";
      # ROCM_PATH = "/opt/rocm";
      # HSA_OVERRIDE_GFX_VERSION="10.3.0";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_IM_MODULE = "ibus";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt"; #Needed for X-Plane "AutoOrtho"
      UV_PYTHON_DOWNLOADS = "never"; # Stop uv from downloading binaries
      VISUAL = "hx";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_SCREENSHOTS_DIR = "$HOME/screenshots";
      XMODIFIERS = "@im=ibus";
      # YDOTOOL_SOCKET = "/run/ydotoold/socket";
      # _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    systemPackages = with pkgs; [
      adwaita-icon-theme
      alsa-utils
      bibata-cursors
      cmake
      desktop-file-utils
      gcc
      glib
      gitFull
      gnumake
      gsettings-desktop-schemas
      libcxxStdenv # Needed to build binaries for tree-sitter
      lua-language-server
      # mfcl2700dnlpr # Remove for now.. too many issues.
      # mfcl2700dncupswrapper # See above
      neovim
      nixfmt-rfc-style
      nodePackages.bash-language-server
      pciutils
      pulseaudioFull
      # rocmPackages.clr
      unar
      unzip
      usbutils
      xdg-utils # for opening default programms when clicking links
      zip
    ];
  };
}
