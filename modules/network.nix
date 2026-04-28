_:
{
  networking = {
    hostName = "halcyon";
    firewall = {
      allowedTCPPorts = [ 80 3002 8080 2121 2234 6475 6476 11434 53317 57621 ];
      allowedUDPPorts = [ 5353 11434 36475 53317 ];
      interfaces."podman+".allowedUDPPorts = [ 53 ];
    };
    networkmanager = {
      enable = true;
    };
  };
}
