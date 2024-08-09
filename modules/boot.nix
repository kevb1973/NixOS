{ config, pkgs, lib, ...}:
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
      systemd.network.wait-online.enable = false;
    };
    # --- BOOT LOADER --- {{{2
    loader = {
      systemd-boot.enable = true;
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
    # --- KERNEL PARAMS --- {{{2
    kernelParams = [
      #"initcall_blacklist=acpi_cpufreq_init"
      #"amd_pstate=active"
      # "nowatchdog"
      # "nmi_watchdog=0"
      "quiet"
      # "amd_iommu=on"
      # "iommu=pt"
    ];
  };
}
