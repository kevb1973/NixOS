{
  pkgs,
  ...
}:
{
  systemd = {

    coredump = {
      enable = true;
      settings.Coredump = {
        Storage = "none";
        ProcessSizeMax = "0";
      };
    };

    services = {
      systemd-vconsole-setup.after = [ "local-fs.target" ]; # fix slow boot caused by vconsole-setup
    };

    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };

    tpm2.enable = false; # see https://www.reddit.com/r/NixOS/comments/1hazcra/nixos_takes_forever_to_boot_suddenly/

    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
