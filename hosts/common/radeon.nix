{ inputs, config, lib, pkgs, ... }:
{
# AMD
  #boot.initrd.kernelModules = [ "amdgpu" ];
  #services.xserver.videoDrivers = [ "modesetting" ];
 # OpenGL
  #hardware.opengl = {
  #  enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
  #  extraPackages = with pkgs; [
  #    rocmPackages.clr.icd
  #  ];
  #};
  #hardware.enableRedistributableFirmware = true;
  #hardware.enableAllFirmware = true;

}
