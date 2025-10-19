{ pkgs, ... }:
{
  boot = {
    extraModprobeConfig = ''
      options kvm ignore_msrs=1
    '';
    tmp.useTmpfs = true;
    kernelModules = [ "i2c-dev" ];
    kernelPackages = pkgs.linuxPackages_latest;
    swraid.enable = false; # Setting needed as system state ver < 23.11
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd = {
        enable = true; # Supposedly results in faster boot?
        network.wait-online.enable = false;
      };
      verbose = false; #for silent boot
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
      "quiet" #for silent boot 
      "splash" #for silent boot 
      "boot.shell_on_fail" #for silent boot 
      "loglevel=3" #for silent boot 
      "rd.systemd.show_status=auto" #for silent boot 
      "rd.udev.log_level=3" #for silent boot 
      "udev.log_priority=3" #for silent boot 
      "amd_iommu=on"
      "iommu=pt"
      "preempt=full" # suggested to avoid audio cracks/noises
      # "systemd.mask=systemd-vconsole-setup.service" # Added due to VConsole error on boot. See https://github.com/NixOS/nixpkgs/issues/312452#issuecomment-2320993345
      "systemd.mask=dev-tpmrm0.device"
    ];
    consoleLogLevel = 3; 
    
  };
}
