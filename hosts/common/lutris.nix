
{ inputs, config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
        # List package dependencies here
      ];
    })
  ];
}
