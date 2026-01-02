_:
{
  networking = {
    dhcpcd.enable = false; # Disable for networkd
    hostName = "halcyon";
    # nameservers = [ "9.9.9.9" "2620:fe::fe" ];
    # dhcpcd.extraConfig = "nohook resolv.conf";
    firewall = {
      allowedTCPPorts = [ 80 3002 8080 2121 2234 6475 6476 11434 53317 57621 ];
      allowedUDPPorts = [ 5353 11434 36475 53317 ];
      interfaces."podman+".allowedUDPPorts = [ 53 ];
    };
    useNetworkd = true;
    wireless = {
      enable = true; # Enables wireless support via wpa_supplicant.
      userControlled = true;
    };
    # networkmanager = {
    #   enable = true;
    #   # dns = "none";
    # };
  };
}
