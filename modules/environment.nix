{ pkgs, inputs, ... }:
{
  environment = {
    pathsToLink = [ "/libexec" ]; # enable polkit
    etc = {
      # "xdg/gtk-3.0".source = ./gtk-3.0;
      # "xdg/gtk-4.0".source = ./gtk-4.0;
      # "xdg/wallpaper".source = ./wallpaper;
      "nix/inputs/nixpkgs".source =
        "${inputs.nixpkgs}"; # needed to fix <nixpkgs> on flake. See also nix.nixPath
    };
    sessionVariables = {
      HSA_OVERRIDE_GFX_VERSION="10.3.0";
    };
    variables = {
      # NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland (Logseq doesn't like it.. slow start, crashy)
      ALTERNATE_EDITOR = ""; #allow emacsclient to start daemon if not already running
      AMD_VULKAN_ICD = "RADV";
      BEMENU_OPTS = "--hf '#5e81ac' --tf '#5e81ac' --fn 'mono 30'";
      CLUTTER_BACKEND = "wayland";
      # DISPLAY = ":0";
      EDITOR = "hx";
      # GDK_BACKEND = "wayland,x11";
      GTK_IM_MODULE = "ibus";
      GTK_THEME="Adwaita:dark";
      MANPAGER = "nvim +Man!";
      MANWIDTH = "100";
      NIX_ALLOW_UNFREE = "1";
      NIXOS_CONFIG = "/home/kev/NixOS";
      OLLAMA_HOST = "0.0.0.0:11434";
      OLLAMA_FLASH_ATTENTION = "1";
      ROCM_PATH = "/opt/rocm";
      HSA_OVERRIDE_GFX_VERSION="10.3.0";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_IM_MODULE = "ibus";
      QT_QPA_PLATFORM = "wayland;xcb";
      # QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt"; #Needed for X-Plane "AutoOrtho"
      VISUAL = "hx";
      VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      XDG_SCREENSHOTS_DIR = "/home/kev/screenshots";
      XMODIFIERS = "@im=ibus";
      YDOTOOL_SOCKET = "/run/ydotoold/socket";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    systemPackages = with pkgs; [
      adwaita-icon-theme
      alsa-utils
      # any-nix-shell
      cmake
      desktop-file-utils
      gcc
      glib
      gitFull
      gnumake
      jdk
      libcxxStdenv # Needed to build binaries for tree-sitter
      lua-language-server
      mfcl2700dnlpr
      mfcl2700dncupswrapper
      neovim
      nixfmt-rfc-style
      # nix-tree # Explore package dependencies
      nodePackages.bash-language-server
      pciutils
      pulseaudioFull
      rocmPackages.clr
      unar
      unzip
      usbutils
      xdg-utils # for opening default programms when clicking links
      zip
    ];
  };
}
