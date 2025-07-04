_:
{
  networking = {
    hostName = "halcyon";
    # nameservers = [ "9.9.9.9" "2620:fe::fe" ];
    # dhcpcd.extraConfig = "nohook resolv.conf";
    firewall.allowedTCPPorts = [ 80 3002 8080 2121 2234 6475 6476 11434 53317 57621 ];
    firewall.allowedUDPPorts = [ 5353 11434 36475 53317 ];
    # interfaces.enp42s0.wakeOnLan.enable = true;
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager = {
      enable = true;
      # dns = "none";
    };
  };
}
