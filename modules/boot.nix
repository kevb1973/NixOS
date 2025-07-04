{ pkgs, ... }:
{
  boot = {
    extraModprobeConfig = ''
      options kvm ignore_msrs=1
    '';
    tmp.useTmpfs = true;
    kernelModules = [ "i2c-dev" ];
    # kernelPackages = pkgs.linuxPackages_latest;
    swraid.enable = false; # Setting needed as system state ver < 23.11
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd = {
        enable = true;
        network.wait-online.enable = false;
      };
      verbose = false; #for silent boot (plymouth)
    };
    loader = {
      systemd-boot.enable = true;
      timeout = 1; 
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernelParams = [
      "quiet" #for silent boot (plymouth)
      "splash" #for silent boot (plymouth)
      "boot.shell_on_fail" #for silent boot (plymouth)
      "loglevel=3" #for silent boot (plymouth)
      "rd.systemd.show_status=false" #for silent boot (plymouth)
      "rd.udev.log_level=3" #for silent boot (plymouth)
      "udev.log_priority=3" #for silent boot (plymouth)
      "amd_iommu=on"
      "iommu=pt"
      "systemd.mask=systemd-vconsole-setup.service" # Added due to VConsole error on boot. See https://github.com/NixOS/nixpkgs/issues/312452#issuecomment-2320993345
      "systemd.mask=dev-tpmrm0.device"
    ];
    plymouth = {
      enable = false; # disable for now. Only see it for a second anyways.
    };
    consoleLogLevel = 0; #for silent boot (plymouth)
    
  };
}
