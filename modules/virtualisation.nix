_:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
    oci-containers.backend = "podman";
    
    # libvirtd = {
    #   enable = true;
    #   onBoot = "ignore";
    #   onShutdown = "shutdown";
    #   qemu = {
    #     runAsRoot = true;
    #   };
    # };
  };
}
