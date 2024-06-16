{ inputs, config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.tiling-assistant
    # gnomeExtensions.ddterm
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.kimpanel
    # gnomeExtensions.paperwm
    gnomeExtensions.just-perfection
  ];
}
