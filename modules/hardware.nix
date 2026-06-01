{ lib, ...}:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.amd.updateMicrocode = true; 
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    usbStorage.manageShutdown = true;
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
