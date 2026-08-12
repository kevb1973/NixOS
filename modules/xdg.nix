{pkgs, ...}:
{
  xdg = {
    portal = {
      config.common.default = "*"; # Needed for xdg-desktop-portal
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "brave.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "brave.desktop";
        "application/x-extension-html" = "brave.desktop";
        "application/x-extension-shtml" = "brave.desktop";
        "application/x-extension-xht" = "brave.desktop";
        "application/x-extension-xhtml" = "brave.desktop";
        "application/x-shellscript" = "nvim.desktop";
        "application/xhtml+xml" = "brave.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "audio/flac" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "text/*" = "nvim.desktop";
        "text/css" = "nvim.desktop";
        "text/html" = "brave.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "nvim.desktop";
        "text/xml" = "nvim.desktop";
        "video/*" = "vlc.desktop";
        "x-scheme-handler/http" = "brave.desktop";
        "x-scheme-handler/https" = "brave.desktop";
        "x-scheme-handler/mpv" = "vlc.desktop";
      };
    };
  };
}
