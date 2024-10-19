_:
{
  virtualisation = {
    docker = {
      enable = false;
    };
    # oci-containers = {
    #   backend = "podman";
    #   containers = {
    #     open-webui = import ./containers/open-webui.nix;
    #   };
    # };
    podman = {
      enable = false;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu = {
        runAsRoot = true;
      };
    };
  };
}
