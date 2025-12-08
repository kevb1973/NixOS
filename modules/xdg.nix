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
        "application/x-extension-htm" = "zen.desktop";
        "application/x-extension-html" = "zen.desktop";
        "application/x-extension-shtml" = "zen.desktop";
        "application/x-extension-xht" = "zen.desktop";
        "application/x-extension-xhtml" = "zen.desktop";
        "application/x-shellscript" = "Helix.desktop";
        "application/xhtml+xml" = "zen.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "Helix.desktop";
        "text/css" = "Helix.desktop";
        "text/html" = "zen.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "Helix.desktop";
        "text/xml" = "Helix.desktop";
        "video/*" = "umpv.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/mpv" = "open-in-mpv.desktop";
      };
    };
  };
}
