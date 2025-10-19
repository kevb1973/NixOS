{
  # pkgs,
  ...
}:
{
  systemd = {
    coredump.enable = false;
    network.wait-online.enable = false; # Disable systemd "wait online" as it gets stuck waiting for connection on 2nd NIC
    services = {
      NetworkManager-wait-online.enable = false;
      systemd-vconsole-setup.after = [ "local-fs.target" ]; # fix slow boot caused by vconsole-setup
    };
    settings.Manager = {
      DefaultTimeoutStopSec = "10s";
    };

    tpm2.enable = false; # see https://www.reddit.com/r/NixOS/comments/1hazcra/nixos_takes_forever_to_boot_suddenly/

    # tmpfiles.rules = [
    #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    # ];
  };
}
