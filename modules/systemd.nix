{
  pkgs,
  ...
}: {
  systemd = {
    extraConfig = ''
      DefaultTimeoutStopSec=10s
    '';
    network.wait-online.enable = false; # Disable systemd "wait online" as it gets stuck waiting for connection on 2nd NIC
    services = {
      NetworkManager-wait-online.enable = false;
      greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    };

    # timers.podman-auto-update = {
    #   enable = true;
    #   timerConfig = { OnCalendar = "03:00"; };
    # };
    
    tpm2.enable = false; #see https://www.reddit.com/r/NixOS/comments/1hazcra/nixos_takes_forever_to_boot_suddenly/

    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
