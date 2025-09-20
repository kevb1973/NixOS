{ lib, ...}:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.amd.updateMicrocode = false; # Checking to see if it's actually updating..
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      # extraPackages = with pkgs; [
        # rocmPackages.clr.icd
        # rocmPackages.rocm-smi
      # ];
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };

  swapDevices = [
    {
      # 8 gig swapfile to compliment zram.
      device = "/var/lib/swapfile";
      size = 8*1024;
    }
  ];
  zramSwap.enable = true;
}
