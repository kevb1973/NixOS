{pkgs, ...}:
{
  xdg = {
    portal = {
      enable = true;
       extraPortals = with pkgs; [
         # xdg-desktop-portal-wlr
         xdg-desktop-portal-gtk
       ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "sioyek.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "vivaldi-stable.desktop";
        "application/x-extension-html" = "vivaldi-stable.desktop";
        "application/x-extension-shtml" = "vivaldi-stable.desktop";
        "application/x-extension-xht" = "vivaldi-stable.desktop";
        "application/x-extension-xhtml" = "vivaldi-stable.desktop";
        "application/x-shellscript" = "Helix.desktop";
        "application/xhtml+xml" = "vivaldi-stable.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "Helix.desktop";
        "text/css" = "Helix.desktop";
        "text/html" = "vivaldi-stable.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "Helix.desktop";
        "video/*" = "umpv.desktop";
        "x-scheme-handler/chrome" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";
        "x-scheme-handler/mpv" = "open-in-mpv.desktop";
      };
    };
  };
}
