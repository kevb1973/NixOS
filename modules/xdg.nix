{ ... }:
{
  xdg = {
    # --- Portals{{{2
    portal = {
      enable = true;
       # extraPortals = with pkgs; [
         # xdg-desktop-portal-wlr
         # xdg-desktop-portal-gtk
       # ];
    };
    # --- Mime Types{{{2
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
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
        "video/*" = "umpv.desktop";
        "x-scheme-handler/chrome" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mpv" = "open-in-mpv.desktop";
      };
    };
  };
}
