{pkgs, ...}:
{
  xdg = {
    portal = {
      config.common.default = "*"; # Needed for xdg-desktop-portal
      enable = true;
       extraPortals = with pkgs; [
         xdg-desktop-portal-wlr
         xdg-desktop-portal-gtk
         xdg-desktop-portal-gnome
         # kdePackages.xdg-desktop-portal-kde
       ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "helium.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "helium.desktop";
        "application/x-extension-html" = "helium.desktop";
        "application/x-extension-shtml" = "helium.desktop";
        "application/x-extension-xht" = "helium.desktop";
        "application/x-extension-xhtml" = "helium.desktop";
        "application/x-shellscript" = "nvim.desktop";
        "application/xhtml+xml" = "helium.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "audio/flac" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "nvim.desktop";
        "text/css" = "nvim.desktop";
        "text/html" = "helium.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "nvim.desktop";
        "text/xml" = "nvim.desktop";
        "video/*" = "vlc.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
        "x-scheme-handler/mpv" = "vlc.desktop";
      };
    };
  };
}
