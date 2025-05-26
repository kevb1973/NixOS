_:
{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
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
