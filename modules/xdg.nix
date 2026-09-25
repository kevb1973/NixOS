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
        "application/pdf" = "zen-beta.desktop";
        "application/vnd.apple.mpegurl" = "vlc.desktop";
        "application/x-extension-htm" = "zen-beta.desktop";
        "application/x-extension-html" = "zen-beta.desktop";
        "application/x-extension-shtml" = "zen-beta.desktop";
        "application/x-extension-xht" = "zen-beta.desktop";
        "application/x-extension-xhtml" = "zen-beta.desktop";
        "application/x-shellscript" = "neovide.desktop";
        "application/xhtml+xml" = "zen-beta.desktop";
        "audio/x-mpegurl" = "vlc.desktop";
        "audio/flac" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
        "image/png" = "feh.desktop";
        "inode/directory" = "nnn.desktop";
        "text/*" = "neovide.desktop";
        "text/css" = "neovide.desktop";
        "text/html" = "zen-beta.desktop";
        "text/markdown" = "calibre-ebook-viewer.desktop";
        "text/plain" = "neovide.desktop";
        "text/xml" = "neovide.desktop";
        "video/*" = "vlc.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/mpv" = "vlc.desktop";
      };
    };
  };
}
