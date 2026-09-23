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
        "application/pdf" = "firefox.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "firefox.desktop";
        "application/x-extension-html" = "firefox.desktop";
        "application/x-extension-shtml" = "firefox.desktop";
        "application/x-extension-xht" = "firefox.desktop";
        "application/x-extension-xhtml" = "firefox.desktop";
        "application/x-shellscript" = "neovide.desktop";
        "application/xhtml+xml" = "firefox.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "audio/flac" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "inode/directory" = "nnn.desktop";
        "text/*" = "neovide.desktop";
        "text/css" = "neovide.desktop";
        "text/html" = "firefox.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "neovide.desktop";
        "text/xml" = "neovide.desktop";
        "video/*" = "vlc.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/mpv" = "vlc.desktop";
      };
    };
  };
}
