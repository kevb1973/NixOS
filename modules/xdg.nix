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
       ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "sioyek.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-shellscript" = "Helix.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "Helix.desktop";
        "text/css" = "Helix.desktop";
        "text/html" = "firefox.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "Helix.desktop";
        "text/xml" = "Helix.desktop";
        "video/*" = "umpv.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mpv" = "open-in-mpv.desktop";
      };
    };
  };
}
