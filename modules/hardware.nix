{ pkgs, lib, ...}:
{
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    cpu.amd.updateMicrocode = false; # Checking to see if it's actually updating..
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        # rocmPackages.clr.icd
        # rocmPackages.rocm-smi
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "performance";
  };
}
