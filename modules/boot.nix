{ pkgs, ... }:
{
  boot = {
    extraModprobeConfig = ''
      options kvm ignore_msrs=1
    '';
    tmp.useTmpfs = true;
    # kernelModules = [ "amd-pstate" ];
    kernelPackages = pkgs.linuxPackages_latest;
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
      timeout = 0; #for silent boot (plymouth)
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      # grub = {
      #   enable = false;
      #   copyKernels = true;
      #   efiSupport = true;
      #   devices = [ "nodev" ];
      #   useOSProber = true;
      # };
    };
    kernelParams = [
      #"initcall_blacklist=acpi_cpufreq_init"
      #"amd_pstate=active"
      # "nowatchdog"
      # "nmi_watchdog=0"
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
      enable = true;
    };
    consoleLogLevel = 0; #for silent boot (plymouth)
    
  };
}
